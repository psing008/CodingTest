# CodingTest
Features I could have added
  1. Instead of caching in the Object Models  
    a. Cache on dish, [NSArchiving][NSUnarchiver]
    b. Using [NSCache] for performance.
    c. Implment a ModelContext Class that is resposnible for caching, layer that sits between APIManager and ViewModels
    
  2. Could have used CoreData to cache user list so next load is faster and only update if fetch is made.
  3. Could have made a UIImageView Category to handle image download and setting image, remove code from datasource
  
  4. Could have added UISearchController for user to use search capability.
  5. Unit Tests
