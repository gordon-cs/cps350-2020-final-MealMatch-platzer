# CPS350 Final App: NoReservations
by Evan Platzer

## Project Proposal

This app aims to help users decide what nearby restaurant to eat at. The target users are anyone who frequently has difficulty choosing a restaurant to eat at, singly and especially as a group. NoReservations finds all restaurants nearby (within a radius chosen by the user) and displays them one at a time, letting the user swipe yes to like a restaurant or no to discard it. The user can view their liked restaurants, and they will be suggested restaurants that other members of their group have liked. 

This system helps groups decide because each person can make decision about what they want without worrying about forcing their opinions on the other members of the group. Taking each option one at a time also helps prevent analysis paralysis by confronting the user with a simple yes or no. This allows them to make a simpler, quikcer decision instead of having to weigh all the options against each other simultaneously.

### User Stories

* A user can't decide where to eat, so he opens the app, starts a table with a search radius of 10 miles, and swipes no on several restaurants until the app presents a new italian place he decides to try.

* A user wants to reach consensus on where her group of 5 colleagues should go for lunch. She opens the app and starts a table. Her colleagues join her table and they begin swiping through restaurants.  4 of her colleagues like a sushi place nearby, but she can't eat sushi so she rejects it and they keep swiping until they all agree on a burger joint in the area.

* A user wants a say in where his group is going to eat, so he joins his group's table and begins swiping until they find a good match.

### UI

The UI of NoReservations is broken into six pages:

1. The home page, which links to the table host and the table selection page.s

![The home page](/Storyboard/home.jpg)

2. The table host page, which links to the choose restuarant page.

![The table host page](/Storyboard/host.jpg)

3. The table selection page, which links to the table guest page.

![The table selection page](/Storyboard/tables.jpg)

4. The table guest page, which links to the choose restaurant page.

![The table guest page](/Storyboard/table_guest.jpg)

5. The choose restaurant page, which is accessible from both the table host and table guest pages.

![The choose restaurant page](/Storyboard/choose_restaurant.jpg)

6. Finally, the settings page, which is accessible via the settings button from every other page. The settings page is only needed for behaviors beyond those in the prototype, and so is not going to be implemented in the prototype.

![The settings page](/Storyboard/settings.jpg)

### Prototype

The prototype of this application, which is scheduled to be completed by April 24, 2020, should include the following:

* The ability to host a table, visible to other users of the app.
* The ability to set the search radius of a table that the user is hosting.
* The ability to see a table currently being hosted by another user of the app.
* The ability to join another user's table as a guest.
* The ability for all users at a table to choose restaurants.
  * The ability to swipe through restaurants in the search radius of the table, based on the host's location.
  * The ability to see any restaurant that has been liked by every user at the table.

### APIs

NoReservations makes use of two APIs and one iOS Framework:

1. The [Google Places API](https://developers.google.com/places/web-service/intro) - used to find all restaurants nearby the host user, via the Nearby Place Search route.

2. The [Google Maps API](https://developers.google.com/maps/documentation/ios-sdk/intro) - used to display a map with a marker for the restaurant that the using is currently deciding on.

3. The [Apple Multipeer Connectivity Framework](https://developer.apple.com/documentation/multipeerconnectivity) - used to connect users in the form of "tables".
