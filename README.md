# PromoListDemoApp

Features:

Display a list of promo/offers to the user.
Detail screen contains full detail of promo/offer.
A guarantee that main thread will never be blocked.

Additional modules:

Integration with 3rd party libraries
SDWebImage- for asynchronous image downloader

Requirements:

iOS 10.0 or later
Xcode 10.0 or later
Swift 5

Approach taken to develop this App:

MVVM architecture- View Model(PromoViewModel) that represents the data for the view and the business logic. View (PromoListVC) will consists of a simple UITableView control, which uses the default UITableView cell for display. Model (PromoModel) will consists of properties that can provide the promo related data.
SDWebImage library for image catching
NSUrlSession for network call in ApiRequest class.
