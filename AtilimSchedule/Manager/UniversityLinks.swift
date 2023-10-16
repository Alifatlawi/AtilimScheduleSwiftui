
import Foundation

class UniversityLinks: ObservableObject {
    @Published var links: [String: String] = [:]
    
    func updateLinks(completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "https://www.atilim.edu.tr/en/dersprogrami") else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(error)
                return
            }
            
            guard let htmlString = String(data: data, encoding: .utf8) else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode HTML"]))
                return
            }
            
            let linkKeywords = [
                "engineering": "https://atilimengr",
                "business": "https://atilimmgmt",
                "artsAndSciences": "https://atilimartsci",
                "fineArts": "https://atilimgstm",
                "healthSciences": "https://atilimhlth",
                "civilAviation": "https://atilimcav",
                // ... other departments if any
            ]
            
            var updatedLinks: [String: String] = [:]
            for (department, keyword) in linkKeywords {
                if let link = self.extractLink(from: htmlString, keyword: keyword) {
                    updatedLinks[department] = link
                }
            }
            
            // Print all extracted links
            print("Extracted Links:")
            for (key, value) in updatedLinks {
                print("\(key): \(value)")
            }
            
            DispatchQueue.main.async {
                self.links = updatedLinks
                completion(nil)
            }
        }
        task.resume()
    }

    
    private func extractLink(from htmlString: String, keyword: String) -> String? {
        if let range = htmlString.range(of: keyword, options: .caseInsensitive) {
            let linkEndIndex = htmlString[range.lowerBound...].firstIndex(of: "\"") ?? htmlString.endIndex
            return String(htmlString[range.lowerBound..<linkEndIndex])
        }
        return nil
    }
}

