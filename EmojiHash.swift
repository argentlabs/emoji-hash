import Foundation

func emojiHash(_ input: String) -> String {
   // HashEmoji.txt is a line separated file of 256 emojis (1 per byte)
   guard let path = Bundle.main.path(forResource: "HashEmoji", ofType: "txt"),
      let emojiData = try? String(contentsOfFile: path, encoding: .utf8)
   else {
      preconditionFailure("HashEmoji resource not available")
   }
   
   let emojis = emojiData.components(separatedBy: .newlines)
  
   // Convert the input string into bytes and hash
   // Note for Ethereum Addresses at Argent we use the hex value without leading 0x
   let data = keccak256(input)
   
   var str = ""
  
   // Given we use keccak as a hash function, we can simply take the first couple of bytes 
   // to represent the level of uniqueness required (based on probability of collision)
   for i in 0..<4 {
      let byte = data.bytes[i]
      str.append(emojis[Int(byte)])
   }

   return str
}