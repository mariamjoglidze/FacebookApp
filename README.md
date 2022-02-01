# FacebookApp

FacebookApp
The FacebookApp uses Facebook SDK, for this we need permissions, so I created Test Users. To see the fuctionality of the app you need to use users token.
Test users's tokens are updated sometimes.

If token has expired you wont't be able to see the user's data, so you need to change the token. for this you need to contact to developer to give you the token
or you can generate the token yourself using the site: https://developers.facebook.com/tools/explorer/?method=GET&path=me%3Ffields%3Did%2Cname&version=v12.0
 and test user's account (user: emma_wedtzmm_watson@tfbnw.net, password: Test123123)  and paste it in the app Facebook/Core/Utilities/Strings.swift and change the value of static let token. After that when you build the app click sign in button you should enter your facebook credentials.

https://user-images.githubusercontent.com/11348262/151986015-3de03482-7951-49f0-a755-709b0e0a9c4b.mp4

developer contact: marijoglidze@gmail.com 599637947
