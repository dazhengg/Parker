

import UIKit
import Foundation
import JSQMessagesViewController
import Firebase

// The following class handles messaging and real time database storage for Firebase
class ChatController: JSQMessagesViewController {
 

    
    var messages = [JSQMessage]()
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()

    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
   func viewDidload() {
    
    }
    
	
	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.navigationBar.isTranslucent = true
	}
  
  
    
    override func viewWillAppear(_ animated: Bool) {
		
		self.navigationController?.navigationBar.isTranslucent = false
        
        let defaults = UserDefaults.standard
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        
   
        if let id = defaults.string(forKey: "jsq_id"), var name = defaults.string(forKey: "jsq_name")
        {
            senderId = id
           
            name += " " + formatter.string(from: Date())
            senderDisplayName = name
            
            let currTime    = name
            let currTimeArr = currTime.components(separatedBy: " ") // :[String] type
            
            let named    = currTimeArr[0]
            let timed = currTimeArr[1]

                let fix_time = named + " " + timed
            senderDisplayName = fix_time
        }
            
        else
        {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = ""
            
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
            
            showDisplayNameDialog()
        }
        
        
         title = "Chat: \(senderDisplayName!)"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
        tapGesture.numberOfTapsRequired = 1
        
        navigationController?.navigationBar.addGestureRecognizer(tapGesture)
        super.viewWillAppear(animated)
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
       
        
        
        super.viewDidAppear(animated)
        
        let query = Constants.refs.databaseChats.queryLimited(toLast: 15)
        
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
    }
    @objc func showDisplayNameDialog()
    {
        let defaults = UserDefaults.standard
        
    
        
        let alert = UIAlertController(title: "Your Display Name", message: "Before you can chat, please choose a display name. Others will see this name when you send chat messages. Change your display name again by tapping the navigation bar. Only one word names will be accepted i.e Bobby, not Bob the Builder", preferredStyle: .alert)
        
        alert.addTextField { textField in
            let whitespace = NSCharacterSet.whitespaces
            
          
        
            
            
            if let name = defaults.string(forKey: "jsq_name")
            {
                textField.text = name
                
            }
            else
            {
                let names = ["Rob", "Bob", "Yeezy", "Jumpman", "Sun", "Rain", "Shine"]
                textField.text = names[Int(arc4random_uniform(UInt32(names.count)))]
            }
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] _ in
         
          
            
            if let textField = alert?.textFields?[0], !textField.text!.isEmpty && textField.text?.range(of: " ") == nil {
                
                self?.senderDisplayName = textField.text
                
                self?.title = "Chat: \(self!.senderDisplayName!)"
                
                defaults.set(textField.text, forKey: "jsq_name")
                defaults.synchronize()
            
            } else {
                self?.senderDisplayName = "Bob"
                let textField = alert?.textFields?[0]
                self?.title = "Chat: \(self!.senderDisplayName!)"
                
                defaults.set(textField?.text, forKey: "jsq_name")
                defaults.synchronize()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }

    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.refs.databaseChats.childByAutoId()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text+"  "+formatter.string(from: Date())]
        
        ref.setValue(message)
        
        
        finishSendingMessage()
    }
}
