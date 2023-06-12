# RickAndMorty
Sample Rick and Morty App built in SwiftUI

![Icon](RickAndMorty/Assets.xcassets/AppIconset/AppIcon.png)

### Branches
The "main" branch currently does not use CoreData for the Rick and Morty characters.
As the results are downloaded 20 characters at a time the results tend to jump, which isn't a good user experience.
Plau as the results are not complete, a search facility has not been added.

The feature branch "007_switch_to_coredata" downloads all the records so has search and sort facilities.
However this branch has a UI issue where the character detail view has the search field showing, which is an error.
The coredata branch has been created to test the switchover to the new SwiftData framework in iOS17, so shouldn't be considered complete in any way.

