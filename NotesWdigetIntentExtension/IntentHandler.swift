//

import Intents

class IntentHandler: INExtension, NoteSelectorIntentHandling {
    func provideItemOptionsCollection(for intent: NoteSelectorIntent, with completion: @escaping (INObjectCollection<Item>?, Error?) -> Void) {
        let item1 = Item(identifier: "a", display: "Note 1", subtitle: "Images: 5", image: nil)
        item1.noteTitle = "Note Title 1"
        item1.imagesNumber = 5
        let item2 = Item(identifier: "b", display: "Note 2", subtitle: "Images: 1", image: nil)
        item2.noteTitle = "Note Title 2"
        item2.imagesNumber = 1
        let items: [Item] = [item1, item2]
        completion(INObjectCollection(items: items), nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
