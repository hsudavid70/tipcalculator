tipcalculator

Submitted by: David Hsu

Time spent: 20 hours

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder.
      This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Light/Dark color themes with switch in settings view
- [X] The bill amount entered supports fractional amounts
- [X] Three sliders can set three preset tip rates in the range 10% to 99%, they automatically adjust for relative value
- [X] The main screen has stepper inputs for the user to enter number of people in the party and finetune tip rates,
      tip and total per person are calculated 


## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/bKFjXFY.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Challenges:

Impelmenting the locale changes and state saving across restarts required looking up references regarding
lifecycle handling, considerable amount of development time was spent on testing / debugging the lifecycle
handling.

This program was developed using Swift 1.2 and tested on iOS simulator with iOS 8.4


## License

    Copyright [2016] [David Hsu]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
