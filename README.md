# Project 3 - *Twitter*

**Twitter** is a Twitter app using the [Twitter API](https://dev.twitter.com/docs).

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
- [X] User can pull to refresh
- [X] User can compose a new tweet by tapping on a compose button.
- [X] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Talking more about the different types of segues and when to use which.
2. Best programming practices with making asynchornous calls in iOS. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://media.giphy.com/media/l3vR61OUEj0RK4hpe/source.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

This project was pretty straight forward for the most part. Unfortunately I didn't have as much time as I'd like to implement and fine tune the product. I'd forgotten to enable key sharing which is a feature that was needed for user persistence. As a result, I was getting 403 Forbidden responses, which unfortunately was really cryptic. I also had a lot of trouble coloring the navigation bar to the color I wanted. 

I think the biggest challenge to me this week was deciding how to show the Compose View. I believe the best practice is to use a modal view, but I had difficulties passing information into the view when I embedded in a navigation control.

Lastly, there was a lot of freedom with how we could design the UI. If I had more time I'd like to explore better ways to arrange the elements on the View.

## License

    Copyright [2016] [Estella Lai]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.