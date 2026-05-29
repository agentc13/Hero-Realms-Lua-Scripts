# Lua Effect Documentation v1.6
WARNING: There's a special random algorithm inside the engine. It is impossible to use lua or any other random inside the script without breaking a game while running your script.


## Changes in 1.6
1. Coop section added
2. backgrounds list added
# Changes in 1.5
1. Bug fixed where some layouts were not working with string expressions
2. getCardNameStringExpression(selector) added, returning name of the first card in selector, so you can use it to display card name whereever you want as string expression
3. getFactionCount(selector) added, counting number of distinct factions in selector
4. Reserve should now be working whenever you have any cards in reserve scroller
5. skillSacrificePloc exposed. Contains cards sacrificed from skills scroller (abilities etc)
6. moveToBottomDeckTarget(isHidden, order, playerExpression) added, allowing bottomdecking to any player’s deck
7. createCardFromIdEffect(id, locExpression) added allowing creating a card using card string id. Like “influence”
8. createAbilitySlot(t) now accepts t.displayText to be displayed when buffed card is zoomed in
9. winEndReason, concedeEndReason extra end game reasons exposed over API
10. appendEffect(effect) added, allowing to send an effect to the end of current effects queue (needed for endturneffect)
11. .OrBool(boolExpression) added to allow chaining simple bool check along with card bool expressions. selector.where(isChampion().And(isCardStunned().OrBool(yourBookCheckHere)))
12. player.cards.reserve added. you may put reserve cards there in script init data structure, no extra scripting needed
13. reservePloc exposed via API
14. randomStringExpression(expressions) added, allowing to pick one random from the list provided
15. setPlayerNameExpressionEffect(name, player) added, so you can set player name using string expression
16. noHeal player slot added, when on player - they can’t be healed
17. healOverride player slot added. when on player - they get healed for 5 on their turn start instead of discarding a card
18. healInsteadOfEffect(effect, healAmount) effect added. It heals for healAmount if healOverride is on current player
19. controllerPid added - current card controller. Different from owner - player the card originated from
20. isCardWithSlot(slotKey) card bool expression added
21. isCardWithSlotString(slotKey, stringValue) - checks if card has a slot with a key and certain string value
22. isCardAffordableExt(extraGold) - same as isCardAffordable, but you may also specify amount if virtual gold added to you actual gold (usable for cases like
23. hasCardTag(tag) bool card expression added to check if card has given tag
# Changes in 1.4
1. divide(intDividendExpression, intDivisorExpression) added
2. selector.avg(intCardExpression) added
3. showTextExpressionEffect added
4. Dynamic layouts - see “Dynamic string generation” section
# Changes in 1.3
1. getHeroLevel intExpression added
2. getCardPrintedCost intExpression added
3. intExpression players slots added
# Changes in 1.2
1. More ability triggers
2. Custom ability triggers
# Changes in 1.1
1. IMPORTANT - set of mandatory player buffs changed. Check updated example scripts and update your scripts correspondingly
2. transformTarget now properly changes card face on the board
3. nuUndoEffect renamed to noUndoEffect
4. createNoStunSlot added
5. createNoDamageSlot added
6. onZeroHealthTrigger added
7. onLeavePlay trigger added
8. drawToLocation can now directly accept integer
9. createLayout(t) is now only way to create layouts for all types of items - cards, abilities, choices
10. deck management fixed and should be more flexible now. you may easily clear hero deck on start now. See example_script_vs_ai_advanced_deck_management.lua for reference
11. more frames. Frames with faction icon on another side added
12. storytelling effects section added
13. coop scenarios development support (see coop_pirates_example.lua)
14. new card formatting option in “xmltext” field. See examples below. You may still use “text” for simple things, but for complex formatting - only xmltext
15. new arts available


# Requirements

**Minimal requirements:**

- Steam - no other platform supports development mode
- basic knowledge of script programming
- any text editor (notepad works just fine)

**Optimal requirements:**

- Steam - no other platform supports development mode
- LUA scripting language experience
- text editor with syntax highlight support (notepad++, sublime, vsCode)
# How to start
## Development
1. Have a text editor installed. Any editor works for this, but better grab one with LUA syntax highlight support.
2. Set up a folder for your scripts on hard drive. For best results, try not to include any special symbols in either directory name/path and file name. Do not rename or move the folder after creation, as path to the script on your hard drive is used for versioning. If your script changes path of file name, it will be recognised as a new script.
3. Put a sample script into that folder
4. in the app, open settings and navigate to game tab. There - set development mode to ON. NOTE: it’s visible only on desktop.
![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688058452469_image.png)



4. Now you have “Develop” menu item in main menu
5. It opens Script Editor screen
6. There, click “Open” button, navigate to the folder you created on step 2 and select a script to use.
7. Only one script is loaded into editor and can be uploaded at a time
![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688059017626_image.png)

8. You may either click edit icon and script will open in your system default editor. Or you may load script into editor of your choice and it will be reloaded when you get back into script editor screen.
9. If script contains errors, error icon will appear, showing full error text when clicked.
![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688059744029_image.png)

10. Play button lets you test your script in Pass’n’Play mode.
11. When you think your script is ready for the world - tap upload icon and script upload screen will open
![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688059791833_image.png)

12. Fill all the values, making sure they are informative enough. 
13. Script name will appear on online lobby tiles, and longer description will appear on script selection screen and in in-game menu.
![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688060019008_image.png)



![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688060074122_image.png)


























14. Choose an image for your  scriptget
15. Click underlined EULA link and either accept or decline it.
16. Upload button appears only if you have accepted the terms.
## Using your scripts online
1. After upload, you may challenge anyone with your script.
2. To do that, go to online challenge screen, tap game type selector button and choose “Custom” option
![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688060197533_image.png)

3. Fill you opponent name, other options and click “Challenge” button
4. On “Select Script” screen, click “My scripts” tile and there you find scripts you uploaded.
## Verification and Favorities

When you successfully uploaded your script, there’s a chance it still contains bugs, so initially script has “Not verified” status.
To get verified, you need to play a full game to the win on one of the sides.
Only after game finishes gracefully, script is marked as Verified and may now be added Favorities by other players.

To add script to favorities, tap on ended custom script game and select “Add to Favorities” option.

![](https://paper-attachments.dropboxusercontent.com/s_8F32093F9D1BC25CDB861F9978E50FF5798A412C3D7094A6FD010F642CC00894_1688060845796_image.png)


Note that you can’t fav your own script.

## Versioning

After some time, you might want to update your script to balance it or fix some bugs that were not found during initial playtesting.
To do that, just upload your fixed script version from the same hard drive location as original one.
New version needs another round of verification.

# Script Engine Reference

The rule engine is built using a few concepts that are combined together to form the full effect system that is used to implement all the cards and effects in the game

Selectors are used to select cards, e.g. cards in the market row, cards in hand, champions with 3 or more defence etc.

Effects are used to change the game state, e.g. sacrifice, add combat etc.

We combine selectors and effects to implement most things in the game, e.g. sacrifice a card in hand.

Abilities are used to hold effects and their trigger times (i.e. when the effect happens). For example:

Gold card ability:

- Trigger: when played
- Effect: Gain 1 gold

Effects can be combined by sequenced them into longer chains of effects. For example,

Command card ability:

- Trigger: when played
- Effect: Sequence of (gain 2 gold, gain 3 combat, gain 4 health, draw a card)

Some abilities can automatically be triggered when a condition happens, e.g 

Arkus’s Ally Ability:

- Trigger: automatic
- Trigger condition: When Imperial ally ability is met
- Effect: Gain 6 health


## Players

Predefined constants to select players:

currentPid -  current player
nextPid - next player to take a turn
oppPid - opponent of current player
nextAllyPid - next ally player
nextOppPid - next opponent
ownerPid - card owner
controllerPid - current card controller

## End game reason
    winEndReason - win
    concedeEndReason - concede


## Locations

To specify a location:

loc(player, ploc), where ploc is (ends with Ploc or player loc):

inPlayPloc - champions location
discardPloc - discard pile
handPloc 
castPloc - played non-champion cards (items and actions)
deckPloc - deck pile
buffsPloc - special location, where buff cards should be created
skillsPloc - skills, abilities and armors around avatar
revealPloc - common reveal location for any cards that get revealed to both players
myRevealPloc - used when you need to reveal cards only to player
sacrificePloc - where cards go after sacrifice
skillSacrificePloc - where ability and any other cards from skills scroller go when sacrificed
reservePloc - reserve cards chest

also, predefined locs without a need to specify player (ends with -Loc):

centerRowLoc
fireGemsLoc
tradeDeckLoc
revealLoc

currentInPlayLoc
currentCastLoc
currentDeckLoc
currentHandLoc
currentDiscardLoc
currentBuffsLoc
currentSkillsLoc
currentRevealLoc

**Examples**:


    -- these two are the same
    currentInPlayLoc
    loc(currentPid, inPlayPloc)


## Factions


    wildFaction
    guildFaction
    necrosFaction
    imperialFaction

Setting card faction:

    local card = createActionDef({
        id = "dragon_fire",
        name = "Dragon Fire",
        tags = { galleryCardTag, callToArmsSetTag },
        types = { dragonType },
        factions = { imperialFaction },
        acquireCost = 7,


## BoolCardExpressions (TODO: check if all expressions are present)

They all start with isCard*() and used to check cards state. Mostly used when filtering selectors

isCardExpended()
isCardStunned()
isCardStunnable()
isCardChampion()
isCardAction()
isCardFaction(*imperialFaction*)
isCardType(*knifeType*) -> checks type and subtype
isCardName(“thief_throwing_knife”) → checks card id
isCardAtLoc(ploc) → true if target is in the passed CardLocEnum
isGuard()
isCardHasController(playerExpression)
isCardFactionless()
isCardAffordable() - checks if you have enough gold to buy it considering any effective cost changes
isCardSkill()
isCardAbility()
isCardAquirable() - checks if you are able to purchase it if you had enough gold
isCardSelf() - checks if card is the origin of an effect executing
isCardDamaged()
isCardExpended()
isCardWithSlot(slotKey)
isCardWithSlotString(slotKey, stringValue) - checks if card has a slot with a key and certain string value
isCardAffordableExt(extraGold) - same as isCardAffordable, but you may also specify amount if virtual gold added to you actual gold.
hasCardTag(tag) bool card expression added to check if card has given tag

operators
.And(isCardXX()) - bool and
 .Or(isCardXX()) - bool or 
 .invert() - bool not
 .OrBool(boolExpression) - allows to or with a simple boolExpression, not card one
Note that these are uppercase, as and/or are keywords in lua

**Usage**
Bool card expressions are mostly used to filter out data from selectors (see below)

**Examples**:


    -- selects cards from opponent's in play, which are not expended and can be stunned
    
    selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))


## Selectors 
## TODO: check if there are more predefined selectors

Selectors are used to start a chain of selecting cards. All selectors start with the selectX:

selectLoc(loc): select cards in a location
selectSource(): select source card
selectTargets(): selects target from targeted effect or cardeffect ability trigger.
selectOppStunnable(): select all opponent’s champions that can be stunned
saveTarget(key) - saves targets under key name
selectSavedTargets(key) - selects saved targets
clearTargets(key) - clears targets for the key

**Filtering**

selector.where(BoolCardExpression) to filter by a property on each card

Example:


    -- selects cards from opponent's in play, which are not expended and can be stunned
    
    selectLoc(loc(oppPid, inPlayPloc)).where(isCardExpended().invert().And(isCardStunnable()))

**Chaining**

selector1.union(selector2) to return the union of both selectors.


    -- returns cards from the market and fire gems
    selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAffordable().And(isCardAcquirable()))

selector.exclude(selectSource()) to exclude the source card

**Ordering**

selector.order(intcardexpression) to order by the provided value
.orderDesc(intcardexpression)

.reverse() to reverse the order

selector.take(n) to take the first X cards
.take(intExpression)

**Conversions**

To Int: .count()

or
.sum(intcardexpression) , e.g. .sum(getCardCost())

You can use .take(1).sum(getCardCost()) to get the cost of a single card, e.g. for comparison

.avg(intCardExpression) - returns average value of int card values for the selector

**Predefined selectors**

We predefine commonly used selectors in lua

selectCurrentChampions()
selectNextChampions()
sacrificeSelector(selector) - special selector, to be used to get cards that can be sacrificed. E.g. if you have a noSacrifice slot on a card this selector will exclude it from the list.

**Examples**

to select all stunned champions

selectCurrentChampions().where(isCardStunned())

to count all cards in opponent’s hand

selectLoc(loc(nextPid, handPloc)).count()

action cards in trade row

selectLoc(centerRowLoc).where(isCardAction())


## IntExpression TODO: check if we have all int expressions specified here

Most int expressions start with get-

From selector: selector.count()

getCounter(counter)
getPlayerHealth(pid)
getHeroLevel(pid)
getCurrentPlayerCombat()
getOppPlayerCombat()
getPlayerGold(pid)
getPlayerDamageReceivedThisTurn(pid)
getTurnsPlayed(pid)
getSacrificedCardsCounter()
getRankedFactionCount(rank) - returns number of faction cards for current player for the given rank. Where rank 1 faction has most cards.
getChampionsPlayedThisTurn() 
getFactionCount(selector) - counting number of distinct factions in selector


constant int:
const(int)

Arithmetic
.add(intExpression), .multiply(intExpression), .negate()
use negate with add to subtract

divide(intDividendExpression, intDivisorExpression)

Comparison: 
.gte(intExpression or int), .lte(intExpression or int), .eq(intExpression or int)

Used when you need to check for something - returns BoolExpression

Conditional:
ifInt(boolExpression, intExpression1, intExpression2) - if bool true - returns expression1, otherwise expression 2

Operations:

minInt(intExp, intExp) - returns min of two values


## StringExpression

There are several places where we can show dynamic strings. To create a dynamic string, just use the format function.

**String format**
format(“{0}”, { int, intexpression etc})

    format("{0} {1}.", { randomNameTitle, randomName})

**Random string expression**
randomStringExpression(expressions) - returns random string expression from provided array

    local randomNameTitle = randomStringExpression({
        "Mr.",
        "Mrs.",
        "Ms.",
        "Dr.",
        "Prof."
    })

**getCardName**
getCardNameStringExpression(selector) - returns name of the first card from selector

**getCurrentGender**

    getCurrentGender() - returns either male of female string

**ifElseString**
ifElseString(boolExpression, yesStringExpression, noStringExpression)

    ifElseString(condition,
            toStringExpression("an"),
            toStringExpression("a"))

**S****witch string**
switchString(intExpression, { string items array}
Returns corresponding value based on incoming int

    switchString(
            intExprValue,
            {
                stringItem(8, "Wild"),
                stringItem(4, "Imperial"),
                stringItem(2, "Necros"),
                stringItem(1, "Guild"),
            })
## Dynamic string generation

Sometimes you might need to calculate text on a card in runtime.

Any text on a card, a choice or other text fields can now be dynamic.

Examples:

Targeted effect:

    local val = minInt(toIntExpression(v), currentHand().count())
    return pushTargetedEffect({
        desc = format("Discard {0} card(s)", { val }),

Layout:

    layout = layoutCard({
        title = "Heal Myself",
        art = "art/cleric_lesser_resurrect",
        text = format("{{{0} health}}", { currentV }),
        flavor = format("Health: {0}", { getPlayerHealth(currentPid) })
    })

Choices:

    layout = createLayout({
        name = "Dispersion",
        art = "art/classes/alchemist/dispersion",
        frame = "frames/alchemist_frames/alchemist_skill_cardframe",
        text = format("Gain {0} <sprite name=\"health\">", { getRankedFactionCountInPlay(1).add(getRankedFactionCountInPlay(2)) })
    }),

Certain effect:

    simpleMessageExpressionEffect(format("{0} Summoning Power", {getCounter("summon_meter")}))
## IntCardExpression

These start with getCard-

getCardCost()
getCardPrintedCost()
getCardHealth()


## BoolExpression

hasClass(playerExpression, heroClass)
hasPlayerSlot(playerExpression, slot)
constBoolExpression(value) - constant value
isWinner(playerExpression) - checks if player is a winner, useful for after game ends effects

**Negate**

.invert() to negate, e.g. isExpended().invert() returns false if the card is expended (not is a reserved word in lua)

**Combining**

.And(boolExp), .Or(boolExp)


## Extended examples TODO: add more examples for selectors

Select all cards in trade row where their cost is greater than the players’ gold

selectLoc(centerRowLoc).where(getCardCost().gt(getPlayerGold(currentPid)))

Note that getCardCost() is a IntCardExpr, the gt() accepts an IntExpr, which should get upgraded to an IntCardExpr, and the entire expression becomes a boolcardexpr


# Effects
## Simple Effect TODO: check if all available effects are present here

All simple effects end with the word -Effect. These require no input from user.


- endGameEffect()
- showMessageEffect(message)

We can chain simple effects together with

effect1.seq(effect2).seq(effect3)

We can repeat simple effect execution with

effect1.doRepeat(intExpression)

Predefined simple effects:

Game state effects


- addDisplayDiscardEffect(oppPid, const(1)) - adds a number to discard display. Not actually requires anyone to discard. Used for cards like Distracted Exchange and other similar thief skills
- gainCombatEffect(int/expression)
- gainGoldEffect(int/expression)
- gainHealthEffect(int/expression)
- gainToughnessEffect(int/expression)
- drawCardsEffect(int/expression)
- drawToLocationEffect(intExpression, locExpression, order) - draws count cards to location. Order possible values -1, 0. Use one or another depending on deck you’re trying to bottom card to. Bottoms for deck and for discard differ, because cards facing is opposite.
- hitOpponentEffect(int/expression) - deals damage to opponent
- hitSelfEffect(int/expression) - deals damage to self
- oppDiscardEffect(int/expression) - makes opponent discard cards when their turn starts
- createCardEffect(cardId, location) - creates a card at location
- endGameEffect(winnerId, endReason) - ends game with a winner and given reason
- setMarketLengthEffect(int) - sets length of market row to the value
- incrementCounterEffect(string counterId, int(Expression)) - increments given counter by the incoming integer value
- resetCounterEffect(string counterId) - resets counter to 0
- shuffleEffect(locExr) - shuffles all cards contained in the passed location
- shuffleTradeDeckEffect() - shuffles trade deck

**Conditionals**
conditions are bool expressions


- ifEffect(condition, simpleEffect)  - if condition is true, executes the effect
- ifElseEffect(condition, yesSimpleEffect, noSimpleEffect) - if condition is true executes yes effect, otherwise no effect

**Specials**


- noUndoEffect() - prevents user from undoing their actions from this point
- nullEffect() - does nothing - can be used to do nothing in certain cases
- browseCards({ locExpr = …, header = “Header text”, oppHeader = “Header text for opponent”}) - allows to browse cards from a location until dismissed

**Fatigue counter**

fatigueCount(startingTurn, delta, name) - fatigue counter


    local oneSwitch = equalSwitchEffect(
        s.GetCounter(name),
    -- default effect if counter value doesn't match 0 or 1 = 2 in power of counter - 1
    -- in case of 2 - which is first default value hit after starting turn - 2^(2-1) = 2
        getFatigueEffect(s.Power(s.Const(2), s.Minus(s.GetCounter(name), s.Const(1)))),
        e.ValueItem(0, e.NullEffect()),
        e.ValueItem(1, getFatigueEffect(s.Const(1))) 
    )


Random selection

- randomEffect({valueItem1, valueItem2, …}) - value item is an integer/simple effect pair. Integers represent weight of the given item. Say we have 5, 2, 1 items in the list. item with 5 has the most chances to be selected.
- valueItem(int, effect) - creates value item for RandomEffect, where determines probability of an effect to be randomly selected.


    return randomEffect({
        valueItem(5, effect1),
        valueItem(5, effect2),
        valueItem(5, effect3)
    })


- randomChoice(choicesArray1, choicesArray2)


    return randomChoiceEffect({
        choices = {
           {
                effect = effect,
                layout = createLayout()
           },
           {
                effect = effect,
                layout = createLayout()
           }
         },{
        choices_2 = {
           {
                effect = e.CreateFromString("fire_gem", currentHandLoc),
                layout = createLayout()
           },
           {
                effect = e.CreateFromString("fire_gem", currentHandLoc),
                layout = createLayout()
           }
        }
    })


Control flow

- equalSwitchEffect(intExpression, defaultSimpleEffect, valueItems[]) - value item is an integer/simple effect pair. Integers represent value of incoming integer to be compared to. Effect from value item with matching integer will be executed. If none of the items match, default effect is executed.

Animations / text

- animateShuffleDeckEffect(player) - plays deck shuffle animation
- showOpponentTextEffect(text) - shows text to the opponent
- hideOpponentTextEffect(text) - hides previously shown opponent text
- showCardEffect(layout) - you may build a layout to be show to player to several seconds or until clicked. createLayout("avatars/troll", "Injured Troll I", "{3 combat}", "The troll gets angry")
- showTextEffect(text) - shows text on the screen
- waitForClickEffect(playerText, oppText)- shows text to corresponding player and waits for click
- waitForClickExpressionEffect(playerStringExpression, oppTextExpression)- same as previous but with string expression support shows text to corresponding player and waits for click.
- customAnimationEffect({id, player}) - plays a custom animation with “id” for “player”
- cardAbilityAnimationEffect({ id, layout }) - plays card animation with “id” style and “layout” card face
- setPlayerAvatarEffect(avatar, playerExpression) - changes avatar for a hero
- setPlayerNameEffect(name, playerExpression) - changes name of a hero
- showTextExpressionEffect(format, { expressions }) - shows flying text
    showTextExpressionEffect(format("10/3 result: {0}", {divide(10, 3)}))


## Card Effects TODO: check if all effects are listed

Card effects require a list of cards to be supplied, normally via a selector. They end with -Target

Game state card effects


- sacrificeTarget() - sacrifices targets
- acquireForFreeTarget(loc) - acquires targets for free to location
- acquireTarget(int discount, loc) - acquires targets to location with a discount
- addSlotToTarget(slot) - adds a slot to targets
- damageTarget(intExpression) - deals damage to targets
- discardTarget() - discards targets
- expendTarget() - expends targets
- grantHealthToTarget(intExpression) - grants +X defense to target champions
- moveTarget(locExr) - moves targets to location
- moveToBottomDeckTarget(isHidden, order) - order possible values -1, 0. Use one or another depending on deck you’re trying to bottom card to. Bottoms for deck and for discard differ, because cards facing is opposite.
1. moveToBottomDeckTarget(isHidden, order, playerExpression) added, allowing bottomdecking to any player’s deck
- nullTarget() - does nothing
- playTarget() - plays targets
- prepareTarget() - prepares targets
- stunTarget() - stuns target
- transformTarget(cardStringId) - transforms target to a card with the given id
- modifyCardDefTarget(healthDelta, ability) - gives an existing card a modified health value and/or a new ability

Random card effects


- probabilityTarget({ chance, onSuccessTarget, onFailureTarget}) - executes onSuccess target effect with chance probability, otherwise executes onFalureTarget effect.
- randomTarget(intExpression, cardEffect) - passes X random targets to underlying card effect

Animation card effects


- showTextTarget(text) - show the provided text above the target card

Control flow card effects


- ifElseTarget(boolCardExpression, yesCardEffect, noCardEffect) - same as ifElseEffect

Card Effect can be converted into Simple Effect by applying a selector.

Examples:

Sacrifice all cards in the current player’s hand:

sacrificeTarget().apply(selectLoc(loc(currentPid, handPloc)))

We can also convert a simple effect into a card effect by ignoring the target:

ignoreTarget(simpleeffect)


## Targeted Effects

Targeted effects can be pushed into the effect queue with pushTargetedEffect(). They will prompt the player to select a target, and then execute the provided card effect on the targets.

Note that pushTargetedEffect() will return a Simple Effect.

If you call pushTargetedEffect in the middle of a sequence of effects, the pushed effect will not happen until everything else in the sequence has already happened. This means if you want another effect to not happen until after the targeted effect has executed, that other effect must be included in the “targetEffect” field of the table passed to pushTargetedEffect(), e.g. targetEffect=sacrificeTarget().seq(drawCardsEffect(1)).

Also, note that you can use selectTargets() to return the targets while processing a targeted/card effect.

Example to prompt the user to sacrifice a card in hand:


    pushTargetedEffect({
      desc=“Sacrifice a card in hand”,
      min=0,
      max=1,
      validTargets=selectLoc(loc(currentPid, handPloc)),
      targetEffect=sacrificeTarget(),
      tags = { "cheapest" }
    })


## Special target effects

**promptSplit effect**
allows to sort cards from a location.
Used for track and channel abilities.

Example:

    drawToLocationEffect(4, currentRevealLoc)
     .seq(promptSplit({
        selector = selectLoc(currentRevealLoc),
        take = const(4), -- number of cards to take for split
        sort = const(2), -- number of cards to be sorted for ef2
        minTake = const(1), -- number of mandatory cards moved to ef2
        ef1 =moveToTopDeckTarget(true), -- effect to be applied to cards left
        ef2 = discardTarget(), -- effect to be applied to sorted cards
        header = "Careful Track", -- prompt header
        description = "Look at the top four cards of your deck. You may put up to two of them into your discard pile, then put the rest back in any order.",
        rightPileDesc = "Text explaining right pile rules, e.g. ordering",
        pile1Name = "Top of Deck",
        pile2Name = "Discard Pile",
        eff1Tags = { buytopdeckTag },
        eff2Tags = { cheapestTag }
    }))
## Choice Effects

The user will make a choice, then a SimpleEffect will be executed for the chosen item.



    pushChoiceEffect({
      choices={
        {
          layout = ...
          effect=gainCombatEffect(5),
          title = "Extra text displayed over a choice item",
          condition = constBoolExpression(true), -- if condition is not fulfilled - choice would be grayed out
          tags = { tag1, tag2, tag3 }
        },
        {
          effect = healPlayerEffect(currentPid, v),
          layout = createLayout({
              name = "Heal Myself",
              art = "icons/cleric_lesser_resurrect",
              xmlText = [[
              <vlayout>
                  <hlayout flexibleheight="3">
                      <tmpro text="{gold_2}" fontsize="50" flexiblewidth="1"/>
                  </hlayout>
                  <divider/>
                  <hlayout flexibleheight="2">
                      <tmpro text="{scrap}" fontsize="50" flexiblewidth="1"/>
                      <tmpro text="&lt;br&gt; Acquire a card of cost 3 or less." fontsize="20" flexiblewidth="7"/>
                  </hlayout>
              </vlayout>
              ]],
              flavor = format("Health: {0}", { getPlayerHealth(currentPid) }),
              -- condition allows to gray the choice out if there are no targets for it
              condition = e.GteCount(s.CurrentPlayer(CardLocEnum.Sacrifice).where(isCardType(abilityType)), s.Const(1))
          })
        }
      }    
    })

Optionally, you may use pushChoiceEffectWithTitle


    pushChoiceEffectWithTitle({
      choices = ...,
      upperTitle = "Extra text displayed above choice items",
      lowerTitle = "Extra text displayed below choice items"
    })

If you are using the field "text" in createLayout ({   }) and 
want to display the gold/combat/health icon in the description
use {X gold} ; {X combat} ; {X health} where X - count of points


![](https://paper-attachments.dropboxusercontent.com/s_31F66394ABC2465F353C26C1171909EFCCC7A751E53E3C241560ABB665EB7125_1647011256237_ima22ge.png)


Otherwise, use “xmltext” field.

Example:

    layout = createLayout({
        title = "Hunter's Cloak",
        art = "icons/ranger_hunters_cloak",
        text = ("{2 health}")
    }),


Note that choice effects can be dynamically generated using thecreateLayout() function, which returns a dynamic layout for the art. All the fields of createLayout accept StringExpression.


## Storytelling effects

**Speech bubble effect**
Shows a speech bubble for defined player, which may wait to be dismissed or not.

    showSpeechBubbleEffect({
        playerExpression=oppPid,
        text="Lys, your supper is here!",
        waitForClick=constBoolExpression(false)
    })

**Story tell effect effect with portrait**
Shows an avatar sayng a string.

    storyTellEffectWithPortrait("lys__the_unseen", "Delicious…")
    leftStoryTellEffectWithPortrait("lys__the_unseen", "Delicious…") -- shows portrait on left side

**Story lines effect**
Shows strings one after another.

    storyLinesEffect({"You’ve defeated the Necros but lost many allies in the battle.",
                             "You leave the temple, but the surrounding catacombs are like a maze.",
                             "Without the captive Priest for a guide, you quickly become lost."
    })

**Dramatic pause effect**
Does nothing for seconds. Useful when you need a dramatic pause within character dialog

    dramaticPauseEffect(seconds)
# Creating abilities

Abilities link effects with their trigger times.


    createAbility({
      id = "uniqueAbilityId",
      trigger = startOfTurnTrigger, 
      effect = nullEffect(), -- a simple effect to execute
      cost = noCost, -- noCost by default
      activations = singleActivation, -- single by defaule
      check = constBoolExpression(true), -- true by default
      promptType = showPrompt -- noprompt by default,
      allyFactions { guildFaction, wildFaction } -- needs a guild or wild ally in play to activate
    })

**Ability Triggers**


    startOfTurnTrigger
    oppStartOfTurnTrigger
    endOfOppTurnTrigger
    oppStartOfTurnTrigger
    autoTrigger - automatic trigger, like death cultist's expend ability has auto trigger
    onExpendTrigger
    onSacrificeTrigger - pulls this trigger for sacrificed card only
    onSacrificeGlobalTrigger - pulls this trigger for all cards when any card is sacrificed
    onStunTrigger - pulls this trigger for stunned card only
    onStunGlobalTrigger - pulls this trigger for all cards when any card is stunned
    uiTrigger - user will need to manually trigger it
    onAcquireTrigger - triggers this trigger on acquired card
    onAcquireGlobalTrigger - triggers all cards with this trigger
    onPlayTrigger - triggers every time you play any card, not just the card with the onPlay ability
    startOfGameTrigger
    endOfGameTrigger
    onZeroHealthTrigger - triggers when player's health becomes 0 or below
    deckPreShuffleTrigger - triggers before player deck shuffled
    deckShuffledTrigger - triggers when player deck shuffled
    onLeavePlayTrigger - triggers when champion leaves InPlay area
    onDiscardTrigger - triggers from card gets into discard pile
    gainedHealthTrigger - current player gains health (only gains)
    oppGainedHealthTrigger - opponent gained health
    onMarketChangedTrigger - market changed
    onDiscardTrigger - when a card discarded
    onCreateTrigger - a card created
    oppCardDrawnTrigger - opp drew a card

**Custom ability triggers**
You may now create custom ability triggers

    customAbilityTrigger = "customAbilityTrigger"

You may specify it as a trigger for any ablity.
Then you may fire it at any moment:

    fireAbilityTriggerEffect(customAbilityTrigger) -- fire trigger for all cards in play
    
    fireAbilityTriggerForTarget(customAbilityTrigger) -- fire trigger for targets - use with either .apply(selector) or as part or targeted effect

Usage on an ability

    trigger = abilityTrigger(customAbilityTrigger)

**Cost**

Requirements to use the effect, set if required; to give an ability multiple costs, such as expending and also paying gold, use combineCosts(t), passing it a table that contains each of the desired costs, e.g. combineCosts({ expendCost, goldCost(2) })


- expendCost
- sacrificeSelfCost
- goldCost(value)
- sacrificeSelfCost
- combineCosts({ expendCost, goldCost(value) })

**Activations**
Set if required

- singleActivation: normally used with auto abilities to indicate that the ability can only be activated once per turn. Default.
- multipleActivations: used with expend abilities to indicate that it can be activated multiple times per turn.

**PromptType**
Set if you want to show confirmation card before executing ability. 

- noPrompt - default
- showPrompt - enables prompt

**PlayAllType**
Determines what happens when player clicks play all with this ability on a card in hand

    noPlayPlayType -- card won’t be played as part of play all
    blockPlayType -- blocks using play all (elven gift, dark reward)
    playFirstPlayType  -- has priority when using play all
    normalPlayType -- card will be played normally

**Priority**
Trigger priority - when multiple same trigger abilities fire, they are executed in priority order from highest to lowest. 0 by default.

**Layout**
Layout to be displayed when activated via prompt

**Check**
Bool expression to decide if the ability can be triggereautd

**AllyFactions**
Used for Ally Abilities, which can only activate if a card of the specified faction(s) is also in play; required for createUiAllyAbility() and createAutoAllyAbility()


## Creating CardEffectAbilities

Standard Abilities can have the onAcquire trigger, which makes them activate whenever *any* card is acquired (regardless of destination), which can make it difficult to have the ability affect the acquired card, as the onAcquire ability does not have a reference to it. If you want to create an ability that will always be able to affect the specific card that was acquired, you need to give the Card Def a CardEffectAbility. The create<specific>Def() function accepts a cardEffectAbilities table in its table parameter, though the abilities table is still required, even if a card has a CardEffectAbility but no Ability:

    card = createActionDef({
      ...
      abilities = { },
      cardEffectAbilities = {
        createCardEffectAbility({
          trigger = playedCardTrigger,
          effect = expendTarget().apply(selectTargets().where(isCardChampion()))
        })
      },
      ...
    })

There are several possible trigger timings for a CardEffectAbility:

- acquiredCardTrigger - triggers before card is acquired
- locationChangedCardTrigger - triggers when a card is added to the market, created, or moved
- postAcquiredCardTrigger - triggers after card is acquired
- postSelfAcquiredCardTrigger - like postAcquired, but only triggers for the card itself
- playedCardTrigger - triggers after a card is played from hand. The trigger will happen after after played triggers, but before auto triggers happen. This way, if the played card trigger expends a champion, auto triggers will not fire.

CardEffectAbilities must use CardEffects, which require specific card targets. The CardEffectAbility will pass the acquired cmoveard as the target for the CardEffect assigned to it if the trigger is onAcquire or postAcquire; it will pass the card whose location changed if the trigger is onLocationChanged. You can also use selectTargets() to obtain the targets

Additionally, for a card that contains a CardEffectAbility with the onLocationChanged trigger, when that card is first created, that ability will trigger, targeting every possible card.

You can pass a Simple Effect to the CardEffectAbility, it will be auto converted to a CardEffect.


## Creating Card Defs

Finally, we put the abilities into a Card Def to allow us to actually create a card.

`createDef({id, name, cardTypeLabel, playLocation, abilities, types, ….})`

id: a unique id for the card. Better add something, say, your username to the id to avoid breaking your script if we introduce a card with same name. “frostbite_randomnoob”

name: Title of card

abilities: array of abilities that the card will have

cardEffectAbilities: array of card effect abilities

acquireCost: cost to acquire

types: array of strings

health: health/defense for champions

healthType: for champions, its either defenseHealthType (default) or healthHealthType

buffDetails: for global buffs, this creates the display when its clicked for details:

    buffDetails = createBuffDetails({
                art = "wizard_spell_components",
                name = "Soak",
                text = "+1 cost"
            }),

layout: if we want to dynamically generate the card layout, example code: 

    createLayout({
                name = "Little Fire Sacer",
                art = "icons/fighter_knock_back",
                text = "Expend: Sacrifice a card in your hand or discard pile",
                flavor = "Water cleanses all"
            })

See layout text chapter below for more formatting info.

Alternatively, we can load a card texture as layout, e.g.
`loadLayoutTexture("Textures/death_touch")`

cardTypeLabel: type of card, used only for display. Normally auto filled in.

playLocation: where the card is played, one of the player loc, e.g. castPloc for action cards. . Normally auto filled in.

Helper methods for creating card defs. These generally just fill in the required type, playLocation and cardTypeLabel.

createActionDef()

    function dragon_fire_carddef()
        local card = createActionDef({
            id = "dragon_fire",
            name = "Dragon Fire",
            tags = { galleryCardTag, callToArmsSetTag },
            types = { dragonType },
            factions = { imperialFaction },
            acquireCost = 7,
            abilities = {
                createAbility({
                    id = "dragon_fire",
                    effect = gainCombatEffect(7).seq(drawCardsWithAnimation(1)),
                    cost = noCost,
                    trigger = onPlayTrigger,
                    tags = { gainCombatTag, draw1Tag, aiPlayAllTag },
                    aiPriority = toIntExpression(300)
                }),
                createAbility({
                    id = "dragon_fire_sacrifice",
                    layout = loadLayoutData("layouts/firstkickstarter/dragon_fire_sacrifice"),
                    effect = getFireballDamageEffect(4, "art/sets/promos1art/dragon_fire", "art/sets/promos1art/dragon_fire", false);
                    cost = sacrificeSelfCost,
                    trigger = uiTrigger,
                    promptType = showPrompt,
                    tags = { damageTag },
                    aiPriority = toIntExpression(-1)
                })
            },
            layout = loadLayoutData("layouts/firstkickstarter/dragon_fire")
        }
    )

createChampionDef()

    function orc_guardian_carddef()
        return createChampionDef({
            id="orc_guardian",
            name="Orc Guardian",
            types={orcType, noStealType},
            acquireCost=0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility({
                    id="feisty_orcling_auto",
                    trigger=autoTrigger,
                    effect = e.NullEffect()
                })
            },
            layout = createLayout({
                name = "Orc Guardian",
                art = "art/T_Orc_Guardian",
                frame = "frames/Coop_Campaign_CardFrame",
                text = "<i>He's quite defensive.</i>",
                health = 3,
                isGuard = true,
                cost = 1
            })
        })
    end

createItemDef()

    function thief_trick_dice_carddef()
        return createItemDef({
            id = "thief_trick_dice",
            name = "Trick Dice",
            types = { thiefType, weaponType, diceType },
            acquireCost = 0,
            abilities = {
                createAbility({
                    id = "thief_trick_dice",
                    effect = drawCardsEffect(2).seq(forceDiscard(1)),
                    cost = noCost,
                    trigger = onPlayTrigger,
                    playAllType = blockPlayType,
                    tags = { drawTag, discardTag, aiPlayAllTag },
                    aiPriority = toIntExpression(200)
                })
            },
            layout = ...
        })
    end

createBuffDef()

createSkillDef()

    function piracy_carddef()
        return createSkillDef({
            id="piracy",
            name="Piracy",
            abilities = {
                createAbility({
                    id="piracy_auto",
                    trigger=autoTrigger,
                    effect = --showTextTarget("Piracy!").apply(selectSource())
                            showCardEffect(createLayout({
                                name = "Piracy",
                                art = "art/T_Piracy",
                                frame = "frames/Coop_Campaign_CardFrame",
                                text = "Acquire the cheapest card in the market row for free"
                            }))
                            .seq(acquireForFreeTarget().apply(selectLoc(centerRowLoc).where(isCardAcquirable()).order(getCardCost()).take(1)))
                            .seq(ifEffect(selectLoc(currentDiscardLoc).reverse().take(1).sum(getCardCost()).gte(6), showTextEffect("Mighty fine plunder, that one.")))
                })
            },
            layout = createLayout({
                name = "Piracy",
                art = "art/T_Piracy",
                frame = "frames/Coop_Campaign_CardFrame",
                text = "Acquire the cheapest card in the market row for free"
            })
        })
    end

createMagicArmorDef()

    function cleric_shining_breastplate2_carddef()
        local cardLayout = createLayout({
            name = "Shining Breastplate 2",
            art = "icons/cleric_shining_breastplate",
            frame = "frames/Cleric_CardFrame",
            text = "Champion get +1 defense till the end of turn"
        })
        
        return createMagicArmorDef({
            id = "cleric_shining_breastplate2",
            name = "Shining Breastplate 2",
            types = {clericType, magicArmorType, treasureType, chestType},
            layout = cardLayout,
            layoutPath = "icons/cleric_shining_breastplate",
            abilities = {
                createAbility( {
                    id = "cleric_shining_breastplate2",
                    trigger = uiTrigger,
                    activations = singleActivation,
                    layout = cardLayout,
                    effect = pushTargetedEffect(
                        {
                            desc = "Choose a champion to get +1 defense",
                            validTargets =  s.CurrentPlayer(CardLocEnum.InPlay),
                            min = 1,
                            max = 1,
                            targetEffect = grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shield"),
                            tags = {toughestTag}                        
                        }
                    ),
                    cost = AbilityCosts.Expend,
                    check = minHealthCurrent(40).And(selectLoc(currentInPlayLoc).where(isCardChampion()).count().gte(1))
                })
            }        
        })
    end

createHeroAbilityDef()

## Layout Text formatting

To set up layout text, use xmltext field of layout table. Double square brackets allow multiline code for easier reading.


    xmlText = [[
        <vlayout>
            <hlayout flexibleheight="1">
                <tmpro text="{scrap}" fontsize="60" flexiblewidth="1"/>
                <tmpro text="Deal 4 damage to two target champions." fontsize="28" flexiblewidth="7"/>
            </hlayout>
        </vlayout>
    ]]


![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1661177102391_spriteatlas.png)


**Sprites:**
{shield}
{combat} {combat_1} 1-9
{expend_1}
{expend_2}
{expend}
{gold} {gold_1} 1-9
{guard}
{guild}
{health} {health_1} 1 to 9
{imperial}
{necro}
{scrap}
{separator}
{wild}
{requiresHealth_40} 10 - 50 step 5

**Examples:**


    <vlayout>
        <hlayout flexibleheight="2">
                <tmpro text="Draw a card" fontsize="22" flexiblewidth="1" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="7.7">
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1.5"/>
                <vlayout flexiblewidth="8">
                                    <tmpro text="{imperial}  &lt;size=90%&gt;3 {combat}&lt;/size&gt;" fontsize="20" alignment="Left" flexibleheight="1"/>
                                    <tmpro text="{wild}  &lt;size=90%&gt;2 {gold}&lt;/size&gt;" fontsize="20" alignment="Left" flexibleheight="1"/>
                                    <tmpro text="{guild}  &lt;size=90%&gt;Draw a card.&lt;/size&gt;" fontsize="19" alignment="Left" flexibleheight="1"/>
                                    <tmpro text="{necro}  &lt;size=90%&gt;You may sacrifice a card in your hand or discard pile.&lt;/size&gt;" fontsize="19" alignment="Left" flexibleheight="2"/>
                </vlayout>
        </hlayout>
    </vlayout>


![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378004224_image.png)



    <vlayout>
        <hlayout flexibleheight="3">
                <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
                <tmpro text="Choose a card in the market. Acquire it for 1 less or sacrifice it." fontsize="20" flexiblewidth="10" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="2">
                <tmpro text="{scrap}" fontsize="50" flexiblewidth="2" />
                <tmpro text="&lt;space=-3em/&gt;Draw a card" fontsize="20" flexiblewidth="10" />
        </hlayout> 
    </vlayout>
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378216298_image.png)

    <vlayout>
        <hlayout flexibleheight="3">
                <tmpro text="Draw a card. If it has no cost, gain 3 {health}.&lt;br&gt;(May bring above maximum)" fontsize="20" flexiblewidth="1" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="2">
                <tmpro text="{scrap}" fontsize="50" flexiblewidth="1" />
                <tmpro text="&lt;space=-0.7em/&gt;{combat_2}" fontsize="50" flexiblewidth="8" />
        </hlayout>
    </vlayout>
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378256392_image.png)

    <vlayout>
        <tmpro text="Draw 2" fontsize="26" flexibleheight="0.5"/>
        <divider/>
        <hlayout flexibleheight="1">
            <tmpro text="{imperial}" fontsize="40" flexiblewidth="1"/>
            <tmpro text="&lt;cspace=0.5em&gt;{health_5}&lt;/cspace&gt;" fontsize="40" flexiblewidth="7" />
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
            <tmpro text="&lt;cspace=0.5em&gt;{combat_5}&lt;/cspace&gt;" fontsize="40" flexiblewidth="7" />
        </hlayout>
    </vlayout>
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378305254_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{expend}" fontsize="36"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="{combat_1}&lt;size=60%&gt; or &lt;/size&gt;{gold_1}&lt;size=60%&gt; or &lt;/size&gt;{health_1}" fontsize="46" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378595654_image.png)

    xmlText = [[
    <vlayout>
        <box flexibleheight="0.5">
            <tmpro text="Draw 2" fontsize="26"/>
        </box>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{imperial}" fontsize="40"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="&lt;cspace=0.5em&gt;{health_5}&lt;/cspace&gt;" fontsize="40" />
            </box>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{scrap}" fontsize="40"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="&lt;cspace=0.5em&gt;{combat_5}&lt;/cspace&gt;" fontsize="40" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378720692_image.png)

    xmlText = [[
    <vlayout>
        <box flexibleheight="1">
            <tmpro text="{gold_4}" fontsize="36"/>
        </box>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{wild}" fontsize="36"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Opponent discards 1." fontsize="22" />
            </box>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{scrap}" fontsize="36"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="&lt;cspace=0.5em&gt;{combat_4}&lt;/cspace&gt;" fontsize="36" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378741733_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1.8">
            <box flexiblewidth="1">
                <tmpro text="{expend}" fontsize="42"/>
            </box>
            <vlayout flexiblewidth="7">
                <box flexibleheight="1">
                    <tmpro text="{combat_6}" fontsize="36" />
                </box>
                <box flexibleheight="2">
                    <tmpro text="Draw up to one card, then discard that many." fontsize="20" />
                </box>
            </vlayout>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{wild}" fontsize="42"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Draw up to one card, then discard that many." fontsize="20" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378766153_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{requiresHealth_10}" fontsize="72"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Target Champion gets +1{shield} permanently" fontsize="28" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378822046_image.png)

    xmlText = [[
    <vlayout>
        <box flexibleheight="1">
            <tmpro text="{gold_2} or {health_5}" fontsize="42"/>
        </box>
        <box flexibleheight="1">
            <tmpro text="If you have two or more champions, gain both." fontsize="24" />
        </box>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378843081_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{expend_2}" fontsize="72"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="Target player gains 7{health} plus 2{health} for each of their champions, and their champions gain 1{shield} until the end of their turn." fontsize="22" />
            </box>
        </hlayout>
    </vlayout>
    ]]
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378902674_image.png)

    xmlText = [[
    <vlayout>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{expend}" fontsize="42"/>
            </box>
            <vlayout flexiblewidth="7">
                <box flexibleheight="1">
                    <tmpro text="{combat_5}" fontsize="42" />
                </box>
                <box flexibleheight="1">
                    <tmpro text="Draw 1" fontsize="32" />
                </box>
            </vlayout>
        </hlayout>
        <divider/>
        <hlayout flexibleheight="1">
            <box flexiblewidth="1">
                <tmpro text="{imperial}" fontsize="42"/>
            </box>
            <box flexiblewidth="7">
                <tmpro text="{health_6}" fontsize="42" />
            </box>
        </hlayout> 
    </vlayout>
    ]],
![](https://paper-attachments.dropbox.com/s_3393425E83F8175532A1ABBAD0B8649F1F9A50A4DBF53772E500C4EB4C156AC7_1664378926283_image.png)

## Slots TODO: add slots info

There are two types of slots in the engine:

- card slots
- player slots

Slots are customizable objects that can be attached to cards and players for various purposes.
All slots have a lifespan, determined by expiration field.

**Slot Expiry**

    startOfOwnerTurnExpiry
    endOfOwnerTurnExpiry
    endOfTurnExpiry
    leavesPlayExpiry
    linkedExpiry
    neverExpiry
    leavesMarketExpiry


## Card slots

Card slots are used to change card properties in various ways or to set flags for further use.

**Adding slot to a card**

    local slot = createSlot({
      id = noSacrificeSlot,
      expiresArray = { neverExpiry }
    // optional fields
      expireEffect = nullEffect() // effect to execute on expire
    })
    
    addSlotToTarget(slot).apply(selector)

As a card effect, it should either be used as part of targeted effect, or followed by .apply(selector)

**Checking slots**
To check slots, tail selector with .where(isCardWithSlot(“stringSlotKey”))

Available slot types:

*slotNoSacrifice - prevents card from being sacrificed (use sacrificeSelector(selector) to make use of it)*
*slotNoPlay - prevents card from being played*
*slotNoBuy - prevents card from being acquired*
*slotNoStun - card can’t be stunned*
*slotHealthChange - modifies champion’s def*
*slotCostChange - modifies card’s acquire cost*
*slotExpend - card is expended when it has this slot*
*slotFactions - extra factions for a card*
*slotAbility - adds an ability to a card*
*slotNoDamage - card can’t be damaged*
*slotNoAttack - card can’t be directly attacked*

**Factions Slot**
When this slot is attached to a card, it’s considered to have factions specified and this effect falls of when expiration event comes.


    createFactionsSlot({ necrosFaction, guildFaction }, { leavesPlayExpiry, endOfTurnExpiry })

**Ability Slot**
When this slot attached to a card, it also has the ability in it.


    local ab = createAbility({
        id = "expendio",
        effect = prepareTarget().apply(selectSource()),
        cost = noCost,
        check = selectSource().where(isCardExpended()).count().eq(1),
        trigger = autoTrigger,
        activations = singleActivation,
        tags = {  }
    })
    
    createAbilitySlot({
      ability = ab, 
      expiry = { endOfTurnExpiry }},
      displayText = "Text to be displayed when zoomed on card with slot attached"
    })

**Cost change Slot**
Modifies cost of a card it attached to.


    createCostChangeSlot(discount, expiresArray)

if discount is negative, card will cost more.

**NoBuy Slot**
When this slot is attached to a card in the market row, a card can’t be acquired even if you have enough gold.


    createNoBuySlot(expires)

**Health change Slot**
Modifies defense of a card it attached to.


    createCostChangeSlot(discount, expiresArray)

if discount is negative, card will cost more.

**No stun slot**

    createNoStunSlot(expiresArray)

card with this slot can’t be stunned

**No damage slot**

    createNoDamageSlot(expiresArray)

card with this slot can’t be damaged

**Guard switch slot**

    createGuardSwitchSlot(isGuard, expiresArray)

card with this slot has guard set by isGuard parameter

**Custom slots**
Custom slots can be used to set some flag on a card

    createSlot({ id = "abilityActivated", expiry = { endOfTurnExpiry } })


## Player slots

Player slots can be attached to players and then can be checked and used to make decisions.
Player slot consists of a key and optional string value.

For example, slots are used to mark a player as one who has a champion stunned this turn, so phoenix helm could activate.

**Creating player slot**

    createPlayerSlot({ key = "usedSkillThisTurn", expiry = { endOfTurnExpiry } })

**Adding player slot**

    addSlotToPlayerEffect(playerExpression, createPlayerSlot({ key = "usedSkillThisTurn", expiry = { endOfTurnExpiry } }))

**Removing player slot**

    removeSlotFromPlayerEffect(playerExpression, "usedSkillThisTurn")

**IntExpression Player slot**
Using this slot, you may store calculable values for a player and then use them for other things.

    createPlayerIntExpressionSlot(key, intExpression, expiresArray)

You can get total sum of stored values using following function, which is an IntExpression.

    sumIntSlots(playerExpression, key)

**Internal player slots**
*undamageablePlayerSlot - player can’t be damaged.*
untargetable*PlayerSlot - player can’t be damaged.*
noHealKey - player can’t be healed


## Custom indicator

Indicator on player avatar is tied to custom player value. It would appear once value is more than 0 and disappear once value returns to 0.

    gainCustomValueEffect(intExpression)
    getCustomValue(pid) - returns intExpression
    gainCustomValueEffect(getCustomValue(pid).negate()) - sets value to 0

**Warning**: Monk uses this indicator for Tao Lu display. If your script uses custom value and Monk hero is playing it - it will change values unexpectedly. So make sure your general script code is not using it while allowing any hero to play it.

## Examples: TBD
## AI

There are 3 types of AI available in the app:


- createEasyAi()
- createMediumAi()
- createHardAi()


# Coop
## Intro screen setup
****
To customize intro screen, add this function to the end of the script and fill it with data required.
Find available backgrounds at corresponding arts section.

    function setupCoopIntro(encounter)
            encounter.name = "Script name"
            encounter.description = "Complex long description with update date"
            encounter.minlevel = 2
            encounter.maxlevel = 24
            encounter.avatar = "avatars/chest"
            encounter.heroname = "CustomHeroName"
            encounter.backgroundPath = "scenariointrobackgrounds/journeys/confiscate"
            encounter.features = {
                encounter.feature("avatars/ambushers", "feature text1"),
                encounter.feature("avatars/bard_01", "feature text2"),
                encounter.feature("avatars/broyelin", "feature text3")
            }
    end
# Image resources

Those can be art, frames, icons and avatars.
Virtually all arts except frames are interchangeable.
You may use avatars for choices and layouts, but not vice versa.
Path should be set as a path, see exact values below.

## Art

Art folder is used to generate layouts. It determines the art on the card.

Possible values:

    art/gorg__orc_shaman
    art/t_all_heroes
    art/t_all_heroes_2
    art/t_angry_skeleton
    art/t_arkus_imperial_dragon
    art/t_banshee
    art/t_barreling_fireball
    art/t_basilisk
    art/t_battle_cry
    art/t_battle_resurrect
    art/t_black_arrow
    art/t_black_knight
    art/t_blazing_fire
    art/t_blazing_heat
    art/t_bless
    art/t_bless_of_heart
    art/t_bless_of_iron
    art/t_bless_of_soul
    art/t_bless_of_steel
    art/t_bless_the_flock
    art/t_blistering_blaze
    art/t_blow_away
    art/t_borg_ogre_mercenary
    art/t_bounty_collection
    art/t_bribe
    art/t_broadsides
    art/t_broelyn_loreweaver
    art/t_broelyn_loreweaver_old
    art/t_calm_channel
    art/t_capsize
    art/t_captain_goldtooth
    art/t_careful_track
    art/t_cat_familiar
    art/t_cat_familiar_fixed
    art/t_channel
    art/t_chaotic_gust
    art/t_charing_guardian
    art/t_cleric_brightstar_shield
    art/t_cleric_divine_resurrect
    art/t_cleric_everburning_candle
    art/t_cleric_female
    art/t_cleric_hammer_of_light
    art/t_cleric_holy_resurrect
    art/t_cleric_lesser_resurrect
    art/t_cleric_malealternate
    art/t_cleric_mass_resurrect
    art/t_cleric_minor_resurrect
    art/t_cleric_phoenix_helm
    art/t_cleric_redeemed_ruinos
    art/t_cleric_rightous_resurrect
    art/t_cleric_shining_breastplate
    art/t_cleric_talisman_of_renewal
    art/t_cleric_veteran_follower
    art/t_close_ranks
    art/t_command
    art/t_confused_apparition
    art/t_crashing_torrent
    art/t_crashing_wave
    art/t_cristov_the_just
    art/t_cron_the_berserker
    art/t_crushing_strength
    art/t_cult_priest
    art/t_cunning_of_the_wolf
    art/t_dagger
    art/t_darian_war_mage
    art/t_dark_energy
    art/t_dark_reward
    art/t_death_cultist
    art/t_death_threat
    art/t_death_touch
    art/t_deception
    art/t_deep_channel
    art/t_demon
    art/t_devastating_blow
    art/t_devil
    art/t_devotion
    art/t_dire_wolf
    art/t_distracted_exchange
    art/t_divine_resurrect
    art/t_domination
    art/t_dragon_fire
    art/t_drench
    art/t_edge_of_the_moat
    art/t_elf
    art/t_elixir_of_concentration
    art/t_elixir_of_endurance
    art/t_elixir_of_fortune
    art/t_elixir_of_strength
    art/t_elixir_of_wisdom
    art/t_elven_curse
    art/t_elven_gift
    art/t_evangelize
    art/t_expansion
    art/t_explosive_fireball
    art/t_fairy
    art/t_feisty_orcling
    art/t_fierce_gale
    art/t_fighter_crushing_blow
    art/t_fighter_double_bladed_axe
    art/t_fighter_femalealternate
    art/t_fighter_hand_scythe
    art/t_fighter_helm_of_fury
    art/t_fighter_helm_of_fury_2
    art/t_fighter_jagged_spear
    art/t_fighter_male
    art/t_fighter_rallying_flag
    art/t_fighter_seasoned_shield_bearer
    art/t_fighter_sharpening_stone
    art/t_fighter_spiked_pauldrons
    art/t_fighter_sweeping_blow
    art/t_fighter_sweeping_blow_fixed
    art/t_fighter_whirling_blow
    art/t_fighter_whirling_blow_fixed
    art/t_fire_blast
    art/t_fire_bomb
    art/t_fire_gem
    art/t_fire_staff
    art/t_fireball
    art/t_fissure
    art/t_flame_burst
    art/t_flawless_track
    art/t_flesh_ripper
    art/t_flood
    art/t_follower_a
    art/t_follower_b
    art/t_giant_knight
    art/t_glittering_spray
    art/t_glittering_torrent
    art/t_glittering_wave
    art/t_goblin
    art/t_gold
    art/t_grakstormgiant
    art/t_granite_smasher
    art/t_grouptackle
    art/t_growing_flame
    art/t_halfdemon_antonispapantoniou
    art/t_halfdemon_hellfire_shenfei
    art/t_headshot
    art/t_headshot_1
    art/t_heavy_gust
    art/t_heist
    art/t_hitjob
    art/t_holy_resurrect
    art/t_horn_of_calling
    art/t_hunting_bow
    art/t_ignite
    art/t_influence
    art/t_intimidation
    art/t_knock_back
    art/t_knock_down
    art/t_kraka_high_priest
    art/t_krythos_master_vampire
    art/t_large_twister
    art/t_lesser_resurrect
    art/t_lesser_vampire
    art/t_life_drain
    art/t_life_force
    art/t_lift
    art/t_light_crossbow
    art/t_longshot
    art/t_longsword
    art/t_lys_the_unseen
    art/t_man_at_arms
    art/t_man_at_arms_old
    art/t_maroon
    art/t_mass_resurrect
    art/t_master_weyan
    art/t_masterful_heist
    art/t_maurader
    art/t_midnight_knight
    art/t_mighty_blow
    art/t_minor_resurrect
    art/t_misdirection
    art/t_mud_pile
    art/t_myros_guild_mage
    art/t_nature_s_bounty
    art/t_orc
    art/t_orc_grunt
    art/t_orc_guardian
    art/t_orc_riot
    art/t_paladin_sword
    art/t_parov_the_enforcer
    art/t_pick_pocket
    art/t_pilfer
    art/t_pillar_of_fire
    art/t_piracy
    art/t_powerful_blow
    art/t_practiced_heist
    art/t_prayer_beads
    art/t_precision_blow
    art/t_prism_rainerpetter
    art/t_profit
    art/t_pure_channel
    art/t_quickshot
    art/t_raiding_party
    art/t_rake_master_assassin
    art/t_rally_the_troops
    art/t_rampage
    art/t_ranger_fast_track
    art/t_ranger_female_alternate
    art/t_ranger_flashfire_arrow
    art/t_ranger_honed_black_arrow
    art/t_ranger_hunters_cloak
    art/t_ranger_instinctive_track
    art/t_ranger_instinctive_track_fixed
    art/t_ranger_male
    art/t_ranger_pathfinder_compass
    art/t_ranger_snake_pet
    art/t_ranger_sureshot_bracer
    art/t_ranger_twin_shot
    art/t_ranger_unending_quiver
    art/t_rasmus_the_smuggler
    art/t_rayla_endweaver
    art/t_recruit
    art/t_relentless_track
    art/t_resurrect
    art/t_righteous_resurrect
    art/t_rock_guardian
    art/t_rolling_fireball
    art/t_ruby
    art/t_scorching_fireball
    art/t_searing_fireball
    art/t_searing_guardian
    art/t_seek_revenge
    art/t_serene_channel
    art/t_set_sail
    art/t_shadow_spell_09
    art/t_shadow_spell_09_blue
    art/t_shadow_spell_09_green
    art/t_shambling_dirt
    art/t_shield_bearer
    art/t_shining_spray
    art/t_shortsword
    art/t_shoulder_bash
    art/t_shoulder_crush
    art/t_shoulder_smash
    art/t_skeleton
    art/t_skeleton_blue
    art/t_skeleton_green
    art/t_skillful_heist
    art/t_sleight_of_hand
    art/t_small_twister
    art/t_smash_and_grab
    art/t_smashing_blow
    art/t_smooth_heist
    art/t_snapshot
    art/t_soothing_torrent
    art/t_soothing_wave
    art/t_soul_channel
    art/t_spark
    art/t_spell_components
    art/t_spider
    art/t_spiked_mace
    art/t_splashing_wave
    art/t_spreading_blaze
    art/t_spreading_flames
    art/t_spreading_sparks
    art/t_steady_shot
    art/t_stone_golem
    art/t_stone_guardian
    art/t_storm_siregar
    art/t_street_thug
    art/t_strength_in_numbers
    art/t_strength_of_the_wolf
    art/t_sweltering_heat
    art/t_swipe
    art/t_taxation
    art/t_therot
    art/t_the_rot
    art/t_theft
    art/t_thief_blackjack
    art/t_thief_enchanted_garrote
    art/t_thief_female
    art/t_thief_jewelers_loupe
    art/t_thief_keen_throwing_knife
    art/t_thief_knife_belt
    art/t_thief_male_alternate
    art/t_thief_masterful_heist
    art/t_thief_sacrificial_dagger
    art/t_thief_shadow_mask
    art/t_thief_shadow_mask_2
    art/t_thief_silent_boots
    art/t_throwing_axe
    art/t_throwing_knife
    art/t_timelyheist
    art/t_tithe_priest
    art/t_torgen_rocksplitter
    art/t_track
    art/t_triple_shot
    art/t_turn_to_ash
    art/t_twinshot
    art/t_tyrannor_the_devourer
    art/t_unify_apsara
    art/t_varrick_the_necromancer
    art/t_venom
    art/t_violent_gale
    art/t_walking_dirt
    art/t_weak_skeleton
    art/t_well_placed_shot
    art/t_whirling_blow
    art/t_wind_storm
    art/t_wind_tunnel
    art/t_wizard_alchemist_s_stone
    art/t_wizard_arcane_wand
    art/t_wizard_blazing_staff
    art/t_wizard_female_alternate
    art/t_wizard_magic_mirror
    art/t_wizard_magic_mirror_2
    art/t_wizard_male
    art/t_wizard_runic_robes
    art/t_wizard_runic_robes_2
    art/t_wizard_serpentine_staff
    art/t_wizard_silverskull_amulet
    art/t_wizard_spellcaster_gloves
    art/t_wolf_form
    art/t_wolf_shaman
    art/t_word_of_power
    art/t_wurm
    art/t_wyvern
    art/catacombs
    art/cleric_lesser_resurrect
    art/cleric_shining_breastplate
    art/dark_sign
    art/drak__storm_giant
    art/fighter_sweeping_blow_old
    art/fighter_whirling_blow_old
    art/gold_female_black
    art/gold_female_dark
    art/gold_female_pale
    art/gold_female_white
    art/gold_female_white_grayscale
    art/gold_male_black
    art/gold_male_dark
    art/gold_male_pale
    art/gold_male_white
    art/monsters_in_the_dark
    art/ranger_hunters_cloak
    art/the_call
    art/wizard_fireball
    art/ancestry/battle_rage
    art/ancestry/bully
    art/ancestry/burgle
    art/ancestry/crush_you!
    art/ancestry/demon_blood
    art/ancestry/demonic_strength
    art/ancestry/dwarf
    art/ancestry/elf
    art/ancestry/elven_grace
    art/ancestry/elven_wisdom
    art/ancestry/friendly_banter
    art/ancestry/half-demon
    art/ancestry/hammer
    art/ancestry/hammer_strike
    art/ancestry/hellfire
    art/ancestry/hide
    art/ancestry/ogre
    art/ancestry/orc
    art/ancestry/orc_male
    art/ancestry/pick
    art/ancestry/ragged_blade
    art/ancestry/shiny_rock
    art/ancestry/smallfolk
    art/ancestry/sunstone_brooch
    art/ancestry/war_club
    art/epicart/absolve
    art/epicart/abyss_summoner
    art/epicart/aerial_assassin
    art/epicart/alchemist_assassin
    art/epicart/ambush_party
    art/epicart/amnesia
    art/epicart/ancient_chant
    art/epicart/angel_of_death
    art/epicart/angel_of_death_alt
    art/epicart/angel_of_light
    art/epicart/angel_of_mercy
    art/epicart/angel_of_the_gate
    art/epicart/angelic_protector
    art/epicart/angeline_s_favor
    art/epicart/angeline_s_will
    art/epicart/anguish_demon
    art/epicart/ankylosaurus
    art/epicart/apocalypse
    art/epicart/arcane_research
    art/epicart/arm
    art/epicart/army_of_the_apocalypse
    art/epicart/ascendant_pyromancer
    art/epicart/avenger_of_covenant
    art/epicart/avenging_angel
    art/epicart/banishment
    art/epicart/battle_cry
    art/epicart/bellowing_minotaur
    art/epicart/bitten
    art/epicart/blind_faith
    art/epicart/blue_dragon
    art/epicart/bodyguard
    art/epicart/bounty_hunter
    art/epicart/brachiosaurus
    art/epicart/brak__fist_of_lashnok
    art/epicart/brand__rebel_fighter
    art/epicart/brave_squire
    art/epicart/breath_of_life
    art/epicart/bruger__the_pathfinder
    art/epicart/burrowing_wurm
    art/epicart/canopy_ranger
    art/epicart/carrion_demon
    art/epicart/cast_out
    art/epicart/cave_troll
    art/epicart/ceasefire
    art/epicart/chamberlain_kark
    art/epicart/champion_of_the_wicked
    art/epicart/charged_dragon
    art/epicart/chomp
    art/epicart/chomp_
    art/epicart/chronicler
    art/epicart/citadel_raven
    art/epicart/citadel_scholar
    art/epicart/consume
    art/epicart/corpse_taker
    art/epicart/corpsemonger
    art/epicart/courageous_soul
    art/epicart/crystal_golem
    art/epicart/cyan_dragon
    art/epicart/dark_assassin
    art/epicart/dark_eyes
    art/epicart/dark_knight
    art/epicart/dark_leader
    art/epicart/dark_offering
    art/epicart/dark_one_s_apprentice
    art/epicart/dark_one_s_fury
    art/epicart/dark_prince
    art/epicart/deadly_raid
    art/epicart/deathbringer
    art/epicart/demon_breach
    art/epicart/demon_token
    art/epicart/demonic_rising
    art/epicart/den_mother
    art/epicart/devour
    art/epicart/dirge_of_scara
    art/epicart/disappearing_act
    art/epicart/divine_judgment
    art/epicart/djinn_of_the_sands
    art/epicart/dragonling
    art/epicart/drain_essence
    art/epicart/draka__dragon_tyrant
    art/epicart/draka_s_enforcer
    art/epicart/draka_s_fire
    art/epicart/drifting_terror
    art/epicart/drinker_of_blood
    art/epicart/eager_necromancer
    art/epicart/elara__the_lycomancer
    art/epicart/elder_greatwurm
    art/epicart/endbringer_ritualist
    art/epicart/enrage
    art/epicart/ensnaring_rune
    art/epicart/entangling_vines
    art/epicart/erase
    art/epicart/erratic_research
    art/epicart/erwin__architect_of_war
    art/epicart/ethereal_dragon
    art/epicart/evict
    art/epicart/fairy_entrancer
    art/epicart/fairy_trickster
    art/epicart/faithful_pegasus
    art/epicart/feeding_frenzy
    art/epicart/feint
    art/epicart/fiery_demise
    art/epicart/final_task
    art/epicart/fire_shaman
    art/epicart/fire_spirit
    art/epicart/fireball
    art/epicart/fires_of_rebellion
    art/epicart/flame_spike
    art/epicart/flame_strike
    art/epicart/flames_of_furios
    art/epicart/flanking_maneuver
    art/epicart/flash_fire
    art/epicart/flood_of_fire
    art/epicart/forbidden_research
    art/epicart/force_field
    art/epicart/force_lance
    art/epicart/forced_exile
    art/epicart/forcemage_apprentice
    art/epicart/forest_dweller
    art/epicart/forest_giant
    art/epicart/forked_jolt
    art/epicart/forked_lightning
    art/epicart/frantic_digging
    art/epicart/from_beyond
    art/epicart/frost_giant
    art/epicart/fumble
    art/epicart/garbage_golem
    art/epicart/gareth_s_automaton
    art/epicart/gareth_s_juggernaut
    art/epicart/gareth_s_processor
    art/epicart/gareth_s_will
    art/epicart/gift_of_furios
    art/epicart/gladius_the_defender
    art/epicart/go_wild
    art/epicart/gold_dragon
    art/epicart/grave_demon
    art/epicart/great_horned_lizard
    art/epicart/greater_lightning_wurm
    art/epicart/guilt_demon
    art/epicart/halt_
    art/epicart/hand_of_angeline
    art/epicart/hands_from_below
    art/epicart/harbinger_of_anguish
    art/epicart/hasty_retreat
    art/epicart/heinous_feast
    art/epicart/helena_s_chosen
    art/epicart/helion__the_dominator
    art/epicart/helion_s_fury
    art/epicart/herald_of_angeline
    art/epicart/herald_of_lashnok
    art/epicart/herald_of_scara
    art/epicart/high_king
    art/epicart/hill_giant
    art/epicart/howl
    art/epicart/human_token
    art/epicart/hunting_pack
    art/epicart/hunting_pterosaur
    art/epicart/hunting_raptors
    art/epicart/hunting_wyvern
    art/epicart/hurricane
    art/epicart/ice_drake
    art/epicart/imperial_cavalry
    art/epicart/imperial_commander
    art/epicart/infernal_gatekeeper
    art/epicart/infest
    art/epicart/inheritance_of_the_meek
    art/epicart/inner_demon
    art/epicart/inner_peace
    art/epicart/insurgency
    art/epicart/invoke_pact
    art/epicart/javelin_thrower
    art/epicart/juggernaut
    art/epicart/jungle_queen
    art/epicart/justice_prevails
    art/epicart/kalani__woodreader
    art/epicart/keeper_of_secrets
    art/epicart/keira__wolf_caller
    art/epicart/knight_of_elara
    art/epicart/knight_of_glory
    art/epicart/knight_of_shadows
    art/epicart/knight_of_the_dawn
    art/epicart/knight_of_the_dragon
    art/epicart/kong
    art/epicart/krieg__dark_one_s_chosen
    art/epicart/lash
    art/epicart/lashnok_s_will
    art/epicart/lay_claim
    art/epicart/lesser_angel
    art/epicart/lesser_arms
    art/epicart/lesser_chaos
    art/epicart/lesser_demonize
    art/epicart/lesser_devil
    art/epicart/lesser_digging
    art/epicart/lesser_dinosaur
    art/epicart/lesser_dragon
    art/epicart/lesser_elf
    art/epicart/lesser_flame
    art/epicart/lesser_giant
    art/epicart/lesser_golem
    art/epicart/lesser_night_stalker
    art/epicart/lesser_planning
    art/epicart/lesser_squire
    art/epicart/lesson_learned
    art/epicart/lightning_elemental
    art/epicart/lightning_mage
    art/epicart/lightning_storm
    art/epicart/lightning_strike
    art/epicart/little_devil
    art/epicart/lord_of_the_arena
    art/epicart/lurking_giant
    art/epicart/lycomancy
    art/epicart/lying_in_wait
    art/epicart/markus__watch_captain
    art/epicart/marshal
    art/epicart/martial_law
    art/epicart/master_forcemage
    art/epicart/master_zo
    art/epicart/medusa
    art/epicart/memory_spirit
    art/epicart/mighty_blow
    art/epicart/mirage_wielder
    art/epicart/mist_guide_herald
    art/epicart/mobilize
    art/epicart/murderous_necromancer
    art/epicart/muse
    art/epicart/mystic_researcher
    art/epicart/mythic_monster
    art/epicart/necromancer_apprentice
    art/epicart/necromancer_lord
    art/epicart/necrovirus
    art/epicart/new_dawn
    art/epicart/no_escape
    art/epicart/noble_martyr
    art/epicart/noble_unicorn
    art/epicart/novice_wizard
    art/epicart/ogre_mercenary
    art/epicart/owl_familiar
    art/epicart/pack_alpha
    art/epicart/palace_guard
    art/epicart/paros__rebel_leader
    art/epicart/pelios__storm_lord
    art/epicart/plague
    art/epicart/plague_zombies
    art/epicart/plentiful_dead
    art/epicart/polar_shock
    art/epicart/preacher
    art/epicart/priest_of_kalnor
    art/epicart/priestess_of_angeline
    art/epicart/psionic_assault
    art/epicart/psyche_snare
    art/epicart/pyromancer
    art/epicart/pyrosaur
    art/epicart/quell
    art/epicart/rabble_rouser
    art/epicart/rage
    art/epicart/raging_t_rex
    art/epicart/rain_of_fire
    art/epicart/rally_the_people
    art/epicart/rampaging_cyclops
    art/epicart/rampaging_wurm
    art/epicart/raxxa__demon_tyrant
    art/epicart/raxxa_s_curse
    art/epicart/raxxa_s_displeasure
    art/epicart/raxxa_s_enforcer
    art/epicart/reality_shift
    art/epicart/reap_or_sow
    art/epicart/reaper
    art/epicart/red_mist
    art/epicart/rescue_griffin
    art/epicart/reset
    art/epicart/resurrection
    art/epicart/reusable_knowledge
    art/epicart/revolt
    art/epicart/rift_summoner
    art/epicart/rise_of_the_many
    art/epicart/rising_storm
    art/epicart/ritual_of_scara
    art/epicart/royal_escort
    art/epicart/royal_intervention
    art/epicart/run_riot
    art/epicart/runek__dark_duelist
    art/epicart/rybas__canopy_sniper
    art/epicart/sand_wurm
    art/epicart/saren__night_stalker
    art/epicart/savage_uprising
    art/epicart/scara_s_gift
    art/epicart/scara_s_will
    art/epicart/scarred_berserker
    art/epicart/scarred_cultist
    art/epicart/scarred_priestess
    art/epicart/scarros__hound_of_draka
    art/epicart/scrap_golem
    art/epicart/scrap_golem_token
    art/epicart/scrap_token
    art/epicart/sea_hydra
    art/epicart/sea_titan
    art/epicart/second_wind
    art/epicart/secret_legion
    art/epicart/sequester
    art/epicart/shadow_imp
    art/epicart/shield_of_tarken
    art/epicart/shock_trooper
    art/epicart/silver_dragon
    art/epicart/silver_wing_griffin
    art/epicart/silver_wing_guardian
    art/epicart/silver_wing_lancer
    art/epicart/silver_wing_paladin
    art/epicart/silver_wing_savior
    art/epicart/siren_s_song
    art/epicart/sky_serpent
    art/epicart/smash_and_burn
    art/epicart/soul_hunter
    art/epicart/soul_storm
    art/epicart/sparkmage
    art/epicart/spawning_demon
    art/epicart/spike_trap
    art/epicart/spore_beast
    art/epicart/stalking_werewolf
    art/epicart/stampeding_einiosaurus
    art/epicart/stand_alone
    art/epicart/standard_bearer
    art/epicart/stealthy_predator
    art/epicart/steed_of_zaltessa
    art/epicart/steel_golem
    art/epicart/steel_titan
    art/epicart/storm_dragon
    art/epicart/strafing_dragon
    art/epicart/street_swindler
    art/epicart/subjugate
    art/epicart/succubus
    art/epicart/sun_strike
    art/epicart/surprise_attack
    art/epicart/teleport
    art/epicart/temporal_enforcer
    art/epicart/temporal_shift
    art/epicart/temporize
    art/epicart/terrorize
    art/epicart/the_gudgeon
    art/epicart/the_people_s_champion
    art/epicart/the_risen
    art/epicart/thought_plucker
    art/epicart/thrasher_demon
    art/epicart/thundarus
    art/epicart/time_bender
    art/epicart/time_thief
    art/epicart/time_walker
    art/epicart/transfigure
    art/epicart/transform
    art/epicart/transmogrify
    art/epicart/triceratops
    art/epicart/trihorror
    art/epicart/turn
    art/epicart/unquenchable_thirst
    art/epicart/urgent_messengers
    art/epicart/valentia_justice_bringer
    art/epicart/valiant_knight
    art/epicart/vampire_lord
    art/epicart/vanishing
    art/epicart/velden__frost_titan
    art/epicart/vilify
    art/epicart/village_protector
    art/epicart/vital_mission
    art/epicart/wake_the_dead
    art/epicart/war_lion_of_valentia
    art/epicart/war_machine
    art/epicart/war_priest
    art/epicart/warrior_angel
    art/epicart/warrior_golem
    art/epicart/watchful_gargoyle
    art/epicart/wave_of_transformation
    art/epicart/whirlwind
    art/epicart/white_dragon
    art/epicart/white_knight
    art/epicart/wild_roc
    art/epicart/winds_of_change
    art/epicart/winged_death
    art/epicart/winter_fairy
    art/epicart/wither
    art/epicart/wolf_companion
    art/epicart/wolf_s_bite
    art/epicart/wolf_s_call
    art/epicart/wolf_token
    art/epicart/woodland_bushwacker
    art/epicart/word_of_summoning
    art/epicart/wurm_hatchling
    art/epicart/wyvern
    art/epicart/zaltessa_s_fire
    art/epicart/zannos__corpse_lord
    art/epicart/zealous_necromancer
    art/epicart/zombie_apocalypse
    art/epicart/zombie_token
    art/treasures/t_bottle_of_rum
    art/treasures/t_bracers_of_brawn
    art/treasures/t_cleric_elixir_blue_purple
    art/treasures/t_cleric_elixir_golden
    art/treasures/t_cleric_elixir_green
    art/treasures/t_fighter_elixir_blue
    art/treasures/t_fighter_elixir_green
    art/treasures/t_fighter_elixir_red
    art/treasures/t_green_potions_large
    art/treasures/t_green_potions_medium
    art/treasures/t_hook_weapon
    art/treasures/t_imperial_sailor
    art/treasures/t_magic_scroll_souveraine
    art/treasures/t_parrot
    art/treasures/t_pirate_cutlass
    art/treasures/t_ranger_elixir_orange
    art/treasures/t_ranger_elixir_red_brownish
    art/treasures/t_ranger_elixir_yellow
    art/treasures/t_ship_bell
    art/treasures/t_ship_in_a_bottle
    art/treasures/t_spyglass
    art/treasures/t_thief_elixir_black
    art/treasures/t_thief_elixir_red
    art/treasures/t_thief_elixir_white
    art/treasures/t_treasure_map
    art/treasures/t_trick_dice
    art/treasures/t_wizard_elixir_blue
    art/treasures/t_wizard_elixir_orange
    art/treasures/t_wizard_elixir_silver
    art/treasures/alchemist_diamond
    art/treasures/alchemist_kaleidoscope
    art/treasures/alchemist_prismatic_cloak
    art/treasures/alchemist_rainbow_potion
    art/treasures/alchemist_recipe_book
    art/treasures/alchemist_silver_scales
    art/treasures/alchemist_vial_of_acid
    art/treasures/alchemist_waistcoat_of_infinite_pockets
    art/treasures/barbarian_caltrops
    art/treasures/barbarian_cloak_of_rage
    art/treasures/barbarian_double_bladed_hand_axe
    art/treasures/barbarian_net_of_thorns
    art/treasures/barbarian_pillage
    art/treasures/barbarian_roaring_cowl
    art/treasures/barbarian_seething_spear
    art/treasures/barbarian_whip
    art/treasures/bard_captivating_herald
    art/treasures/bard_dancing_shoes
    art/treasures/bard_enchanted_flute
    art/treasures/bard_minstrel_s_gloves
    art/treasures/bard_muse_s_paper
    art/treasures/bard_music_box
    art/treasures/bard_tuning_fork
    art/treasures/bard_whistling_rapier
    art/treasures/cleric_benediction_beads
    art/treasures/cleric_blessed_bracers
    art/treasures/cleric_enduring_follower
    art/treasures/cleric_holy_water
    art/treasures/cleric_mantle_of_rebirth
    art/treasures/cleric_morningstar
    art/treasures/cleric_motes_of_light
    art/treasures/cleric_sacred_censer
    art/treasures/cleric_spiked_mace_of_healing
    art/treasures/cleric_spiked_mace_of_might
    art/treasures/druid_flying_squirrel
    art/treasures/druid_great_stag
    art/treasures/druid_grizzled_pauldrons
    art/treasures/druid_hardy_hedgehog
    art/treasures/druid_lore_telling
    art/treasures/druid_reclaim_the_forest
    art/treasures/druid_sunbird
    art/treasures/druid_verdant_boots
    art/treasures/druid_wisdom_of_the_woods
    art/treasures/fighter_adamantine_breastplate
    art/treasures/fighter_chain
    art/treasures/fighter_dazzling_ruby
    art/treasures/fighter_flaming_longsword
    art/treasures/fighter_iron_shield
    art/treasures/fighter_javelin
    art/treasures/fighter_lightning_longsword
    art/treasures/fighter_runic_throwing_axe
    art/treasures/fighter_spiked_sabatons
    art/treasures/fighter_taunting_talisman
    art/treasures/monk_ancestral_circlet
    art/treasures/monk_arm_bands_of_defense
    art/treasures/monk_dragon_staff
    art/treasures/monk_radiant_blossom
    art/treasures/monk_staff_of_the_phoenix
    art/treasures/monk_tranquil_wind
    art/treasures/monk_void_s_eye
    art/treasures/monk_wraps_of_illusionary_speed
    art/treasures/necromancer_bag_of_bones
    art/treasures/necromancer_bone_gauntlets
    art/treasures/necromancer_company_of_corpses
    art/treasures/necromancer_dread_cauldron
    art/treasures/necromancer_greaves_of_grieving
    art/treasures/necromancer_preserved_heart
    art/treasures/necromancer_soul_cage
    art/treasures/necromancer_withered_wand
    art/treasures/ranger_death_arrow
    art/treasures/ranger_gloves_of_accuracy
    art/treasures/ranger_gold_tipped_arrow
    art/treasures/ranger_hawk_pet
    art/treasures/ranger_horn_of_command
    art/treasures/ranger_horn_of_need
    art/treasures/ranger_stalking_bow
    art/treasures/ranger_tracker_s_boots
    art/treasures/ranger_trick_arrow
    art/treasures/ranger_veiled_trap
    art/treasures/thief_blinding_powder
    art/treasures/thief_brillant_ruby
    art/treasures/thief_hideaway_cloak
    art/treasures/thief_kunai
    art/treasures/thief_lockpick
    art/treasures/thief_lucky_knife
    art/treasures/thief_parrying_dagger
    art/treasures/thief_ruby_encrusted_knife
    art/treasures/thief_sharpened_ruby
    art/treasures/thief_stickyfinger_gloves
    art/treasures/wizard_adept_s_components
    art/treasures/wizard_clock_of_ages
    art/treasures/wizard_combust
    art/treasures/wizard_content_familiar
    art/treasures/wizard_enchanter_s_hat
    art/treasures/wizard_incandescent_sash
    art/treasures/wizard_magic_scroll
    art/treasures/wizard_prestidigitation_charm
    art/treasures/wizard_wand_of_wanting
    art/treasures/wizard_wizened_familiar
    art/campaign/journeys/imperial_persistence
    art/campaign/warinthewild/kasha__the_awakener_cropped
    art/campaign/warinthewild/slaughterclaw
    art/campaign/warinthewild/slaughterclaw_fixed
    art/campaign/warinthewild/slaughterclaw_zoomed
    art/campaign/warinthewild/the_summoning
    art/classes/alchemist/crucible
    art/classes/alchemist/diamond
    art/classes/alchemist/dispersion
    art/classes/alchemist/dissolve
    art/classes/alchemist/fireworks
    art/classes/alchemist/reflection
    art/classes/alchemist/refraction
    art/classes/alchemist/transmogrification
    art/classes/alchemist/transmutation
    art/classes/alchemist/alchemy_powders
    art/classes/alchemist/auric_gloves
    art/classes/alchemist/bottled_tempest
    art/classes/alchemist/brittle_gas
    art/classes/alchemist/fools_gold
    art/classes/alchemist/frothing_potion
    art/classes/alchemist/instant_transmutation
    art/classes/alchemist/major_transmogrification
    art/classes/alchemist/minor_transmutation
    art/classes/alchemist/perfect_refraction
    art/classes/alchemist/philosophers_stone
    art/classes/alchemist/polished_philosophers_stone
    art/classes/alchemist/prismatic_dispersion
    art/classes/alchemist/rainbow_potion
    art/classes/alchemist/rapid_transmogrification
    art/classes/alchemist/rapid_transmutation
    art/classes/alchemist/recalibration_crystal
    art/classes/alchemist/recipe_book
    art/classes/alchemist/sloshing_potion
    art/classes/alchemist/spectrum_spectacles
    art/classes/alchemist/swirling_philosophers_stone
    art/classes/alchemist/vial_of_acid_gas
    art/classes/alchemist/waistcoat_of_infinite_pockets
    art/classes/alchemist/wide_diffusion
    art/classes/barbarian/amulet_of_stifled_pain
    art/classes/barbarian/battle_cry
    art/classes/barbarian/battle_roar_incorrect
    art/classes/barbarian/battle_roar_l3
    art/classes/barbarian/battle_roar_l5
    art/classes/barbarian/bellow
    art/classes/barbarian/bone_axe
    art/classes/barbarian/crushed_coin
    art/classes/barbarian/disorienting_headbutt
    art/classes/barbarian/double_bladed_hand_axe
    art/classes/barbarian/earthshaker
    art/classes/barbarian/eternal_rage_berserk
    art/classes/barbarian/eternal_rage_calm
    art/classes/barbarian/explosive_rage_berserk
    art/classes/barbarian/explosive_rage_calm
    art/classes/barbarian/fiery_rage_berserk
    art/classes/barbarian/fiery_rage_calm
    art/classes/barbarian/flail
    art/classes/barbarian/flaring_rage_berserk
    art/classes/barbarian/flaring_rage_calm
    art/classes/barbarian/growl
    art/classes/barbarian/hand_axe
    art/classes/barbarian/headbutt
    art/classes/barbarian/inner_rage_berserk
    art/classes/barbarian/inner_rage_calm
    art/classes/barbarian/plunder
    art/classes/barbarian/razor_bracers
    art/classes/barbarian/ring_of_rage
    art/classes/barbarian/roar
    art/classes/barbarian/seething_spear
    art/classes/barbarian/serrated_hand_axe
    art/classes/barbarian/shattering_headbutt
    art/classes/barbarian/smoldering_rage_berserk
    art/classes/barbarian/smoldering_rage_calm
    art/classes/barbarian/stomping_boots
    art/classes/barbarian/terrifying_howl
    art/classes/barbarian/terrifying_roar
    art/classes/barbarian/war_cry
    art/classes/barbarian/wolf_companion
    art/classes/bard/bard_battle_march
    art/classes/bard/bard_bold_saga
    art/classes/bard/bard_brave_story
    art/classes/bard/bard_captivating_herald
    art/classes/bard/bard_character_female
    art/classes/bard/bard_character_male
    art/classes/bard/bard_coat_of_encores
    art/classes/bard/bard_collecting_cap
    art/classes/bard/bard_dancing_blade
    art/classes/bard/bard_dancing_shoes
    art/classes/bard/bard_enchanted_flute
    art/classes/bard/bard_epic_poem
    art/classes/bard/bard_flute
    art/classes/bard/bard_goblet_of_whimsy
    art/classes/bard/bard_golden_harp
    art/classes/bard/bard_grand_legend
    art/classes/bard/bard_guild_tale
    art/classes/bard/bard_harp
    art/classes/bard/bard_herald
    art/classes/bard/bard_heroic_fable
    art/classes/bard/bard_imperial_anthem
    art/classes/bard/bard_inspiring_tune
    art/classes/bard/bard_intrepid_tale
    art/classes/bard/bard_lullaby_harp
    art/classes/bard/bard_lute
    art/classes/bard/bard_minstrel_s_gloves
    art/classes/bard/bard_moving_melody
    art/classes/bard/bard_muse_s_paper
    art/classes/bard/bard_music_box
    art/classes/bard/bard_musical_darts
    art/classes/bard/bard_mythic_chronicle
    art/classes/bard/bard_necros_dirge
    art/classes/bard/bard_rally_hymn
    art/classes/bard/bard_rousing_ode
    art/classes/bard/bard_silencing_scepter
    art/classes/bard/bard_song_of_the_wild
    art/classes/bard/bard_songbook
    art/classes/bard/bard_stirring_song
    art/classes/bard/bard_summoning_drum
    art/classes/bard/bard_tuning_fork
    art/classes/bard/bard_valiant_verse
    art/classes/bard/bard_whistling_rapier
    art/classes/druid/animal_strength
    art/classes/druid/bear_form
    art/classes/druid/bear_strength
    art/classes/druid/circlet_of_flowers
    art/classes/druid/entangling_roots
    art/classes/druid/feral_fox
    art/classes/druid/flourishing_staff
    art/classes/druid/forest_fury
    art/classes/druid/forest_rage
    art/classes/druid/forest_vengeance
    art/classes/druid/fox
    art/classes/druid/gnarled_staff
    art/classes/druid/grass_weave_sash
    art/classes/druid/grizzly_form
    art/classes/druid/hardy_hedgehog
    art/classes/druid/heartwood_splinter
    art/classes/druid/hedgehog
    art/classes/druid/honeycomb
    art/classes/druid/lore_telling
    art/classes/druid/nimble_fox
    art/classes/druid/owl
    art/classes/druid/panther_eye_ring
    art/classes/druid/polar_bear_form
    art/classes/druid/pure_bear_form
    art/classes/druid/rabbit
    art/classes/druid/reclaim_the_forest
    art/classes/druid/soul_of_the_forest
    art/classes/druid/spirit_bear_form
    art/classes/druid/spirit_grizzly_form
    art/classes/druid/spirit_of_the_forest
    art/classes/druid/squirrel
    art/classes/druid/sunbird
    art/classes/druid/ursine_rod
    art/classes/druid/way_of_the_forest
    art/classes/monk/monk_amulet_of_resolve
    art/classes/monk/monk_ancestral_circlet
    art/classes/monk/monk_arm_bands_of_defense
    art/classes/monk/monk_calm
    art/classes/monk/monk_cobra_fang
    art/classes/monk/monk_dim_mak
    art/classes/monk/monk_dragon_staff
    art/classes/monk/monk_favored_technique
    art/classes/monk/monk_female
    art/classes/monk/monk_flowing_technique
    art/classes/monk/monk_fluid_technique
    art/classes/monk/monk_focus
    art/classes/monk/monk_focused_strike
    art/classes/monk/monk_horn_of_ascendance
    art/classes/monk/monk_jing
    art/classes/monk/monk_magnificent_blossom
    art/classes/monk/monk_male
    art/classes/monk/monk_masterful_technique
    art/classes/monk/monk_practiced_technique
    art/classes/monk/monk_precise_technique
    art/classes/monk/monk_qi
    art/classes/monk/monk_qigong
    art/classes/monk/monk_radiant_blossom
    art/classes/monk/monk_resplendent_blossom
    art/classes/monk/monk_ring_of_1000_palms
    art/classes/monk/monk_serene_wind
    art/classes/monk/monk_slippers_of_the_crane
    art/classes/monk/monk_spring_blossom
    art/classes/monk/monk_staff_of_meditation
    art/classes/monk/monk_staff_of_the_phoenix
    art/classes/monk/monk_stillness_of_water
    art/classes/monk/monk_striking_cobra
    art/classes/monk/monk_tonfas_of_balance
    art/classes/monk/monk_tranquil_wind
    art/classes/monk/monk_void_s_eye
    art/classes/monk/monk_wraps_of_illusinary_speed
    art/classes/monk/monk_wraps_of_strength
    art/classes/monk/monk_yin_yang
    art/classes/necromancer/anguish_blade
    art/classes/necromancer/animate_dead
    art/classes/necromancer/bag_of_bones
    art/classes/necromancer/bloodrose
    art/classes/necromancer/bone_gauntlets
    art/classes/necromancer/bone_raising
    art/classes/necromancer/bone_waltz
    art/classes/necromancer/bone_waltz_v2
    art/classes/necromancer/collection_of_corpses
    art/classes/necromancer/company_of_corpses
    art/classes/necromancer/corpse_horde
    art/classes/necromancer/corpse_raising
    art/classes/necromancer/dread_cauldron
    art/classes/necromancer/empty_graves
    art/classes/necromancer/final_return
    art/classes/necromancer/fresh_harvest
    art/classes/necromancer/grave_robbery
    art/classes/necromancer/greaves_of_grieving
    art/classes/necromancer/necromancer_female
    art/classes/necromancer/necromancer_male
    art/classes/necromancer/onyx_skull
    art/classes/necromancer/plague_belt
    art/classes/necromancer/preserved_heart
    art/classes/necromancer/puzzle_box
    art/classes/necromancer/raise_dead
    art/classes/necromancer/raise_skeleton
    art/classes/necromancer/reanimate
    art/classes/necromancer/reawaken
    art/classes/necromancer/rod_of_reanimation
    art/classes/necromancer/rod_of_spite
    art/classes/necromancer/rod_of_unlife
    art/classes/necromancer/rotting_crown
    art/classes/necromancer/severing_scythe
    art/classes/necromancer/skeleton_servant
    art/classes/necromancer/skeleton_warrior
    art/classes/necromancer/skull_swarm
    art/classes/necromancer/soul_cage
    art/classes/necromancer/soul_prism
    art/classes/necromancer/stitcher_s_kit
    art/classes/necromancer/strong_bones
    art/classes/necromancer/upgraded_collection_of_corpses
    art/classes/necromancer/voidstone
    art/classes/necromancer/withered_wand
    art/sets/promos1art/afterlife
    art/sets/promos1art/bjorn__the_centurion
    art/sets/promos1art/bloodfang
    art/sets/promos1art/crime_spree
    art/sets/promos1art/devotion
    art/sets/promos1art/dragon_fire
    art/sets/promos1art/droga__guild_enforcer
    art/sets/promos1art/galok__the_vile
    art/sets/promos1art/gorg__orc_shaman
    art/sets/promos1art/kasha__the_awakener
    art/sets/promos1art/legionnaire
    art/sets/promos1art/mobia__elf_lord
    art/sets/promos1art/raiding_party
    art/sets/promos1art/ren__bounty_hunter
    art/sets/promos1art/robbery
    art/sets/promos1art/the_summoning
    art/sets/promos1art/valius_fire_dragon_under_the_rockslide
    art/sets/promos1art/valius__fire_dragon
    art/sets/promos1art/zombie


## Frames

Frames are used to set a frame for a card layout

Possible values:

    frames/Cleric_armor_frame 
    frames/Cleric_CardFrame 
    frames/Fighter_armor_frame 
    frames/Generic_CardFrame 
    frames/Generic_Top_CardFrame 
    frames/Guild_Action_CardFrame 
    frames/Guild_Champion_CardFrame 
    frames/HR_CardFrame_Action_Guild 
    frames/HR_CardFrame_Action_Imperial 
    frames/HR_CardFrame_Action_Necros 
    frames/HR_CardFrame_Action_Wild 
    frames/HR_CardFrame_Champion_Guild 
    frames/HR_CardFrame_Champion_Imperial 
    frames/HR_CardFrame_Champion_Necros 
    frames/HR_CardFrame_Champion_Wild 
    frames/HR_CardFrame_Item_Generic 
    frames/Imperial_Action_CardFrame 
    frames/Imperial_Champion_CardFrame 
    frames/Necros_Action_CardFrame 
    frames/Necros_Champion_CardFrame 
    frames/Ranger_armor_frame 
    frames/Ranger_CardFrame 
    frames/Thief_armor_frame 
    frames/Thief_CardFrame 
    frames/Treasure_CardFrame 
    frames/Warrior_CardFrame 
    frames/warrior_top 
    frames/Wild_Action_CardFrame 
    frames/Wild_Champion_CardFrame 
    frames/Wizard_armor_frame 
    frames/Wizard_CardFrame 
    frames/Cleric_Frames/Cleric_Treasure_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Guild_Action_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Guild_Champion_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Imperial_Action_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Imperial_Champion_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Necros_Action_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Necros_Champion_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Wild_Action_CardFrame 
    frames/FactionFrames_IconOnTheLeft/Wild_Champion_CardFrame 

Icons
Icons may be used for choice layout generation or to set icons for buffs, skills and abilities

Possible values:

    icons/battle_cry
    icons/cleric_battle_resurrect
    icons/cleric_bless
    icons/cleric_bless_of_heart
    icons/cleric_bless_of_iron
    icons/cleric_bless_of_soul
    icons/cleric_bless_of_steel
    icons/cleric_bless_the_flock
    icons/cleric_brightstar_shield
    icons/cleric_divine_resurrect
    icons/cleric_holy_resurrect
    icons/cleric_lesser_resurrect
    icons/cleric_mass_resurrect
    icons/cleric_minor_resurrect
    icons/cleric_phoenix_helm
    icons/cleric_resurrect
    icons/cleric_righteous_resurrect
    icons/cleric_shining_breastplate
    icons/cunning_of_the_wolf
    icons/dark_sign
    icons/evangelize
    icons/fighter_crushing_blow
    icons/fighter_crushing_blow_OLD
    icons/fighter_devastating_blow
    icons/fighter_devastating_blow_OLD
    icons/fighter_group_tackle
    icons/fighter_group_tackle_OLD
    icons/fighter_helm_of_fury
    icons/fighter_knock_back
    icons/fighter_knock_back_OLD
    icons/fighter_knock_down
    icons/fighter_knock_down_OLD
    icons/fighter_mighty_blow
    icons/fighter_mighty_blow_OLD
    icons/fighter_powerful_blow
    icons/fighter_powerful_blow_OLD
    icons/fighter_precision_blow
    icons/fighter_precision_blow_OLD
    icons/fighter_shoulder_bash
    icons/fighter_shoulder_bash_OLD
    icons/fighter_shoulder_crush
    icons/fighter_shoulder_crush_OLD
    icons/fighter_shoulder_smash
    icons/fighter_shoulder_smash_OLD
    icons/fighter_smashing_blow
    icons/fighter_smashing_blow_OLD
    icons/fighter_spiked_pauldrons
    icons/fighter_sweeping_blow
    icons/fighter_sweeping_blow_OLD
    icons/fighter_whirling_blow
    icons/fighter_whirling_blow_OLD
    icons/fire_bomb
    icons/fire_gem
    icons/full_armor
    icons/full_armor_2
    icons/growing_flame
    icons/life_siphon
    icons/orc_raiders
    icons/piracy
    icons/ranger_careful_track
    icons/ranger_careful_track_OLD
    icons/ranger_fast_track
    icons/ranger_fast_track_OLD
    icons/ranger_flawless_track
    icons/ranger_headshot
    icons/ranger_headshot_OLD
    icons/ranger_hunters_cloak
    icons/ranger_instinctive_track
    icons/ranger_instinctive_track_OLD
    icons/ranger_longshot
    icons/ranger_longshot_OLD
    icons/ranger_quickshot
    icons/ranger_quickshot_OLD
    icons/ranger_relentless_track
    icons/ranger_relentless_track_OLD
    icons/ranger_snapshot
    icons/ranger_snapshot_OLD
    icons/ranger_steady_shot
    icons/ranger_steady_shot_OLD
    icons/ranger_sureshot_bracer
    icons/ranger_track
    icons/ranger_track_OLD
    icons/ranger_triple_shot
    icons/ranger_triple_shot_OLD
    icons/ranger_twin_shot
    icons/ranger_twin_shot_OLD
    icons/ranger_well_placed_shot
    icons/ranger_well_placed_shot_OLD
    icons/smugglers
    icons/strength_of_the_wolf
    icons/thief_distracted_exchange
    icons/thief_heist
    icons/thief_heist_OLD
    icons/thief_lift
    icons/thief_lift_OLD
    icons/thief_masterful_heist
    icons/thief_masterful_heist_OLD
    icons/thief_misdirection
    icons/thief_pickpocket
    icons/thief_pickpocket_OLD
    icons/thief_pilfer
    icons/thief_pilfer_OLD
    icons/thief_practiced_heist
    icons/thief_practiced_heist_OLD
    icons/thief_shadow_mask
    icons/thief_silent_boots
    icons/thief_skillful_heist
    icons/thief_skillful_heist_OLD
    icons/thief_sleight_of_hand
    icons/thief_smooth_heist
    icons/thief_smooth_heist_OLD
    icons/thief_swipe
    icons/thief_swipe_OLD
    icons/thief_theft
    icons/thief_theft_OLD
    icons/thief_timely_heist
    icons/thief_timely_heist_OLD
    icons/turn_to_ash
    icons/T_Bounty_Collection
    icons/wind_storm
    icons/wizard_barreling_fireball
    icons/wizard_calm_channel
    icons/wizard_calm_channel_OLD
    icons/wizard_channel
    icons/wizard_deep_channel
    icons/wizard_deep_channel_OLD
    icons/wizard_explosive_fireball
    icons/wizard_fireball
    icons/wizard_fire_blast
    icons/wizard_fire_blast_OLD
    icons/wizard_flame_burst
    icons/wizard_flame_burst_OLD
    icons/wizard_pure_channel
    icons/wizard_pure_channel_OLD
    icons/wizard_rolling_fireball
    icons/wizard_runic_robes
    icons/wizard_scorching_fireball
    icons/wizard_searing_fireball
    icons/wizard_serene_channel
    icons/wizard_serene_channel_OLD
    icons/wizard_soul_channel
    icons/wizard_soul_channel_OLD
    icons/wizard_spellcaster_gloves


## Avatars

You need to specify full path when using for layout.
But only avatar name “assassin”, when used as actual avatar.

Possible values:

    avatars/Alchemist_01
    avatars/Alchemist_02
    avatars/Barbarian_01
    avatars/Barbarian_02
    avatars/ambushers
    avatars/any_scenario_queue
    avatars/assassin
    avatars/assassin_flipped
    avatars/bard_01
    avatars/bard_02
    avatars/broelyn
    avatars/broelyn__loreweaver
    avatars/chanting_cultist
    avatars/chest
    avatars/cleric_01
    avatars/cleric_02
    avatars/cleric_alt_01
    avatars/cleric_alt_02
    avatars/cristov__the_just
    avatars/cristov_s_recruits
    avatars/druid_01
    avatars/druid_02
    avatars/dwarf_cleric_female_01
    avatars/dwarf_cleric_female_02
    avatars/dwarf_cleric_male_01
    avatars/dwarf_cleric_male_02
    avatars/dwarf_fighter_female_01
    avatars/dwarf_fighter_female_02
    avatars/dwarf_fighter_male_01
    avatars/dwarf_fighter_male_02
    avatars/dwarf_ranger_female_01
    avatars/dwarf_ranger_female_02
    avatars/dwarf_ranger_male_01
    avatars/dwarf_ranger_male_02
    avatars/dwarf_thief_female_01
    avatars/dwarf_thief_female_02
    avatars/dwarf_thief_male_01
    avatars/dwarf_thief_male_02
    avatars/dwarf_wizard_female_01
    avatars/dwarf_wizard_female_02
    avatars/dwarf_wizard_male_01
    avatars/dwarf_wizard_male_02
    avatars/elf_cleric_female_01
    avatars/elf_cleric_female_02
    avatars/elf_cleric_male_01
    avatars/elf_cleric_male_02
    avatars/elf_fighter_female_01
    avatars/elf_fighter_female_02
    avatars/elf_fighter_male_01
    avatars/elf_fighter_male_02
    avatars/elf_ranger_female_01
    avatars/elf_ranger_female_02
    avatars/elf_ranger_male_01
    avatars/elf_ranger_male_02
    avatars/elf_thief_female_01
    avatars/elf_thief_female_02
    avatars/elf_thief_male_01
    avatars/elf_thief_male_02
    avatars/elf_wizard_female_01
    avatars/elf_wizard_female_02
    avatars/elf_wizard_male_01
    avatars/elf_wizard_male_02
    avatars/elf_wizard_male_03
    avatars/fighter_01
    avatars/fighter_02
    avatars/fighter_alt_01
    avatars/fighter_alt_02
    avatars/halfdemon_cleric_female_01
    avatars/halfdemon_cleric_female_02
    avatars/halfdemon_cleric_male_01
    avatars/halfdemon_cleric_male_02
    avatars/halfdemon_fighter_female_01
    avatars/halfdemon_fighter_female_02
    avatars/halfdemon_fighter_male_01
    avatars/halfdemon_fighter_male_02
    avatars/halfdemon_ranger_female_01
    avatars/halfdemon_ranger_female_02
    avatars/halfdemon_ranger_male_01
    avatars/halfdemon_ranger_male_02
    avatars/halfdemon_thief_female_01
    avatars/halfdemon_thief_female_02
    avatars/halfdemon_thief_male_01
    avatars/halfdemon_thief_male_02
    avatars/halfdemon_wizard_female_01
    avatars/halfdemon_wizard_female_02
    avatars/halfdemon_wizard_male_01
    avatars/halfdemon_wizard_male_02
    avatars/inquisition
    avatars/krythos
    avatars/lord_callum
    avatars/lys__the_unseen
    avatars/man_at_arms
    avatars/monk_01
    avatars/monk_01_2
    avatars/monk_02
    avatars/monsters_in_the_dark
    avatars/necromancer_01
    avatars/necromancer_02
    avatars/necromancers
    avatars/ogre
    avatars/ogre_cleric_female_01
    avatars/ogre_cleric_female_02
    avatars/ogre_cleric_male_01
    avatars/ogre_cleric_male_02
    avatars/ogre_fighter_female_01
    avatars/ogre_fighter_female_02
    avatars/ogre_fighter_male_01
    avatars/ogre_fighter_male_02
    avatars/ogre_ranger_female_01
    avatars/ogre_ranger_female_02
    avatars/ogre_ranger_male_01
    avatars/ogre_ranger_male_02
    avatars/ogre_thief_female_01
    avatars/ogre_thief_female_02
    avatars/ogre_thief_male_01
    avatars/ogre_thief_male_02
    avatars/ogre_wizard_female_01
    avatars/ogre_wizard_female_02
    avatars/ogre_wizard_male_01
    avatars/ogre_wizard_male_02
    avatars/orc_cleric_female_01
    avatars/orc_cleric_female_02
    avatars/orc_cleric_male_01
    avatars/orc_cleric_male_02
    avatars/orc_fighter_female_01
    avatars/orc_fighter_female_02
    avatars/orc_fighter_male_01
    avatars/orc_fighter_male_02
    avatars/orc_raiders
    avatars/orc_ranger_female_01
    avatars/orc_ranger_female_02
    avatars/orc_ranger_male_01
    avatars/orc_ranger_male_02
    avatars/orc_thief_female_01
    avatars/orc_thief_female_02
    avatars/orc_thief_male_01
    avatars/orc_thief_male_02
    avatars/orc_wizard_female_01
    avatars/orc_wizard_female_02
    avatars/orc_wizard_male_01
    avatars/orc_wizard_male_02
    avatars/orcs
    avatars/origins_flawless_track
    avatars/origins_shoulder_bash
    avatars/pirate
    avatars/profit
    avatars/ranger_01
    avatars/ranger_02
    avatars/ranger_alt_01
    avatars/ranger_alt_02
    avatars/ranger_alt_03
    avatars/rayla__endweaver
    avatars/rayla__endweaver_flipped
    avatars/robbery
    avatars/ruinos_zealot
    avatars/skeleton
    avatars/smallfolk_cleric_female_01
    avatars/smallfolk_cleric_female_02
    avatars/smallfolk_cleric_male_01
    avatars/smallfolk_cleric_male_02
    avatars/smallfolk_fighter_female_01
    avatars/smallfolk_fighter_female_02
    avatars/smallfolk_fighter_male_01
    avatars/smallfolk_fighter_male_02
    avatars/smallfolk_ranger_female_01
    avatars/smallfolk_ranger_female_02
    avatars/smallfolk_ranger_male_01
    avatars/smallfolk_ranger_male_02
    avatars/smallfolk_thief_female_01
    avatars/smallfolk_thief_female_02
    avatars/smallfolk_thief_male_01
    avatars/smallfolk_thief_male_02
    avatars/smallfolk_wizard_female_01
    avatars/smallfolk_wizard_female_02
    avatars/smallfolk_wizard_male_01
    avatars/smallfolk_wizard_male_02
    avatars/smugglers
    avatars/spider
    avatars/summoner
    avatars/tentacles
    avatars/the_wolf_tribe
    avatars/thief_01
    avatars/thief_02
    avatars/thief_alt_01
    avatars/thief_alt_02
    avatars/troll
    avatars/vampire_lord
    avatars/wizard_01
    avatars/wizard_02
    avatars/wizard_alt_01
    avatars/wizard_alt_02
    avatars/wolf_shaman
    avatars/WarInTheWild/Bloodfang
    avatars/WarInTheWild/Gorg__Orc_Shaman
    avatars/WarInTheWild/Gorg__Orc_Shaman_flip
    avatars/WarInTheWild/bjorn__the_centurion
    avatars/WarInTheWild/bjorn__the_centurion_flip
    avatars/WarInTheWild/dark_energy
    avatars/WarInTheWild/death_threat
    avatars/WarInTheWild/domination
    avatars/WarInTheWild/droga__guild_enforcer
    avatars/WarInTheWild/galok__the_vile
    avatars/WarInTheWild/galok__the_vile_flip
    avatars/WarInTheWild/grak__storm_giant
    avatars/WarInTheWild/honed_black_arrow
    avatars/WarInTheWild/kasha__the_awakener
    avatars/WarInTheWild/kasha__the_awakener_cropped
    avatars/WarInTheWild/kasha__the_awakener_flip
    avatars/WarInTheWild/krythos_master_vampire
    avatars/WarInTheWild/mobia__elf_lord
    avatars/WarInTheWild/orc_grunt
    avatars/WarInTheWild/raiding_party
    avatars/WarInTheWild/rampage
    avatars/WarInTheWild/ren__bounty_hunter
    avatars/WarInTheWild/slaughterclaw
    avatars/WarInTheWild/the_call
    avatars/WarInTheWild/the_summoning
    avatars/WarInTheWild/torgen_rocksplitter
    avatars/WarInTheWild/valius__fire_dragon
    avatars/WarInTheWild/wolf_form
    avatars/journeys/abomination
    avatars/journeys/alpha_wolf
    avatars/journeys/andor_the_valiant
    avatars/journeys/broken_tables_and_chairs
    avatars/journeys/command
    avatars/journeys/dire_wolf
    avatars/journeys/droga_guild_enforcer
    avatars/journeys/dwarf_thief_female
    avatars/journeys/fettered_imp
    avatars/journeys/halfdemon_fighter_female
    avatars/journeys/hardy_hedgehog
    avatars/journeys/human_necromancer_male
    avatars/journeys/lenka_the_hunter
    avatars/journeys/olara_the_slayer
    avatars/journeys/orc_wizard_female_02
    avatars/journeys/pelleas__the_seeker
    avatars/journeys/ren_bounty_hunter
    avatars/journeys/robbery
    avatars/journeys/smallfolk_male
    avatars/journeys/veteran_squire
    avatars/journeys/waking_dragon


## Zoomed buffs

These are larger variants of some icons


    zoomedbuffs/cleric_battle_resurrect
    zoomedbuffs/cleric_bless
    zoomedbuffs/cleric_bless_of_heart
    zoomedbuffs/cleric_bless_of_iron
    zoomedbuffs/cleric_bless_of_soul
    zoomedbuffs/cleric_bless_of_steel
    zoomedbuffs/cleric_bless_the_flock
    zoomedbuffs/cleric_brightstar_shield
    zoomedbuffs/cleric_divine_resurrect
    zoomedbuffs/cleric_holy_resurrect
    zoomedbuffs/cleric_lesser_resurrect
    zoomedbuffs/cleric_mass_resurrect
    zoomedbuffs/cleric_minor_resurrect
    zoomedbuffs/cleric_phoenix_helm
    zoomedbuffs/cleric_resurrect
    zoomedbuffs/cleric_righteous_resurrect
    zoomedbuffs/goblin_warlord
    zoomedbuffs/ranger_horn_of_calling
    zoomedbuffs/thief_distracted_exchange
    zoomedbuffs/thief_misdirection
    zoomedbuffs/thief_sleight_of_hand
    zoomedbuffs/wizard_barreling_fireball
    zoomedbuffs/wizard_explosive_fireball
    zoomedbuffs/wizard_fireball
    zoomedbuffs/wizard_rolling_fireball
    zoomedbuffs/wizard_runic_robes
    zoomedbuffs/wizard_scorching_fireball
    zoomedbuffs/wizard_searing_fireball
    zoomedbuffs/wizard_serpentine_staff
    zoomedbuffs/wizard_spell_components


## Coop backgrounds
    scenariointrobackgrounds/pirate
    scenariointrobackgrounds/the_wolf_tribe
    scenariointrobackgrounds/deceptions
    scenariointrobackgrounds/raiding_party
    scenariointrobackgrounds/dark_sign
    scenariointrobackgrounds/orcs
    scenariointrobackgrounds/ruinos_zealot
    scenariointrobackgrounds/inquisition
    scenariointrobackgrounds/test_of_mettle
    scenariointrobackgrounds/the_unseen
    scenariointrobackgrounds/man_at_arms
    scenariointrobackgrounds/ambush_at_the_docs
    scenariointrobackgrounds/profit
    scenariointrobackgrounds/necromancers
    scenariointrobackgrounds/smuggling_operation
    scenariointrobackgrounds/journeys/enraged_bear
    scenariointrobackgrounds/journeys/confiscate
    scenariointrobackgrounds/journeys/reclaim_the_forest
    scenariointrobackgrounds/journeys/sway
    scenariointrobackgrounds/journeys/bounty_collection
    scenariointrobackgrounds/journeys/thrash
    scenariointrobackgrounds/journeys/enthralled_regulars
    scenariointrobackgrounds/journeys/corruption
    scenariointrobackgrounds/journeys/abomination
    scenariointrobackgrounds/journeys/command
    scenariointrobackgrounds/journeys/loot
    scenariointrobackgrounds/journeys/dragon_shard
    scenariointrobackgrounds/warInthewild/torgen_rocksplitter
    scenariointrobackgrounds/warInthewild/krythos_master_vampire
    scenariointrobackgrounds/warInthewild/raiding_party
    scenariointrobackgrounds/warInthewild/the_summoning
    scenariointrobackgrounds/warInthewild/dark_energy
    scenariointrobackgrounds/warInthewild/Kasha__the_Awakener
    scenariointrobackgrounds/warInthewild/galok__the_vile_bonus
    scenariointrobackgrounds/warInthewild/mobia__elf_lord
    scenariointrobackgrounds/warInthewild/rampage
    scenariointrobackgrounds/warInthewild/legionnaire
    scenariointrobackgrounds/warInthewild/death_threat
    scenariointrobackgrounds/warInthewild/grak__storm_giant
    scenariointrobackgrounds/warInthewild/orc_grunt
    scenariointrobackgrounds/warInthewild/honed_black_arrow
    scenariointrobackgrounds/warInthewild/domination
    scenariointrobackgrounds/lys_the_unseen
# Card list

Card available:

    arkus__imperial_dragon_carddef()
    borg__ogre_mercenary_carddef()
    bribe_carddef()
    broelyn__loreweaver_carddef()
    cleric_battle_resurrect_carddef()
    cleric_bless_carddef()
    cleric_bless_of_heart_carddef()
    cleric_bless_of_iron_carddef()
    cleric_bless_of_soul_carddef()
    cleric_bless_of_steel_carddef()
    cleric_bless_the_flock_carddef()
    cleric_brightstar_shield_carddef()
    cleric_divine_resurrect_carddef()
    cleric_everburning_candle_carddef()
    cleric_follower_a_carddef()
    cleric_follower_b_carddef()
    cleric_hammer_of_light_carddef()
    cleric_holy_resurrect_carddef()
    cleric_lesser_resurrect_carddef()
    cleric_mass_resurrect_carddef()
    cleric_minor_resurrect_carddef()
    cleric_phoenix_helm_carddef()
    cleric_prayer_beads_carddef()
    cleric_redeemed_ruinos_carddef()
    cleric_resurrect_carddef()
    cleric_righteous_resurrect_carddef()
    cleric_shining_breastplate_carddef()
    cleric_spiked_mace_carddef()
    cleric_talisman_of_renewal_carddef()
    cleric_veteran_follower_carddef()
    close_ranks_carddef()
    command_carddef()
    cristov__the_just_carddef()
    cron__the_berserker_carddef()
    cult_priest_carddef()
    dagger_carddef()
    darian__war_mage_carddef()
    dark_energy_carddef()
    dark_reward_carddef()
    death_cultist_carddef()
    death_threat_carddef()
    death_touch_carddef()
    deception_carddef()
    dire_wolf_carddef()
    domination_carddef()
    elixir_of_concentration_carddef()
    elixir_of_endurance_carddef()
    elixir_of_fortune_carddef()
    elixir_of_strength_carddef()
    elixir_of_wisdom_carddef()
    elven_curse_carddef()
    elven_gift_carddef()
    fighter_crushing_blow_carddef()
    fighter_devastating_blow_carddef()
    fighter_double_bladed_axe_carddef()
    fighter_group_tackle_carddef()
    fighter_hand_scythe_carddef()
    fighter_helm_of_fury_carddef()
    fighter_jagged_spear_carddef()
    fighter_knock_back_carddef()
    fighter_knock_down_carddef()
    fighter_longsword_carddef()
    fighter_mighty_blow_carddef()
    fighter_powerful_blow_carddef()
    fighter_precision_blow_carddef()
    fighter_rallying_flag_carddef()
    fighter_seasoned_shield_bearer_carddef()
    fighter_sharpening_stone_carddef()
    fighter_shield_bearer_carddef()
    fighter_shoulder_bash_carddef()
    fighter_shoulder_crush_carddef()
    fighter_shoulder_smash_carddef()
    fighter_smashing_blow_carddef()
    fighter_spiked_pauldrons_carddef()
    fighter_sweeping_blow_carddef()
    fighter_throwing_axe_carddef()
    fighter_whirling_blow_carddef()
    fire_bomb_carddef()
    fire_gem_carddef()
    goblin_carddef()
    goblin_warlord_carddef()
    gold_carddef()
    gold_male_black_carddef()
    gold_male_dark_carddef()
    gold_male_pale_carddef()
    gold_male_white_carddef()
    gold_female_black_carddef()
    gold_female_dark_carddef()
    gold_female_pale_carddef()
    gold_female_white_carddef()
    grak__storm_giant_carddef()
    hit_job_carddef()
    influence_carddef()
    intimidation_carddef()
    kraka__high_priest_carddef()
    krythos__master_vampire_carddef()
    life_drain_carddef()
    lightning_gem_carddef()
    lys__the_unseen_carddef()
    man_at_arms_carddef()
    master_weyan_carddef()
    myros__guild_mage_carddef()
    nature_s_bounty_carddef()
    orc_grunt_carddef()
    parov__the_enforcer_carddef()
    potion_carddef()
    potion_of_power_carddef()
    profit_carddef()
    rake__master_assassin_carddef()
    rally_the_troops_carddef()
    rampage_carddef()
    ranger_black_arrow_carddef()
    ranger_careful_track_carddef()
    ranger_fast_track_carddef()
    ranger_flashfire_arrow_carddef()
    ranger_flawless_track_carddef()
    ranger_headshot_carddef()
    ranger_honed_black_arrow_carddef()
    ranger_horn_of_calling_carddef()
    ranger_hunters_cloak_carddef()
    ranger_hunting_bow_carddef()
    ranger_instinctive_track_carddef()
    ranger_light_crossbow_carddef()
    ranger_longshot_carddef()
    ranger_pathfinder_compass_carddef()
    ranger_quickshot_carddef()
    ranger_relentless_track_carddef()
    ranger_snake_pet_carddef()
    ranger_snapshot_carddef()
    ranger_steady_shot_carddef()
    ranger_sureshot_bracer_carddef()
    ranger_track_carddef()
    ranger_triple_shot_carddef()
    ranger_twin_shot_carddef()
    ranger_unending_quiver_carddef()
    ranger_well_placed_shot_carddef()
    rasmus__the_smuggler_carddef()
    rayla__endweaver_carddef()
    reality_prism_carddef()
    recruit_carddef()
    ruby_carddef()
    shortsword_carddef()
    smash_and_grab_carddef()
    spark_carddef()
    spiked_mace_carddef()
    street_thug_carddef()
    taxation_carddef()
    tentacle_carddef()
    tentacle_whip_carddef()
    the_rot_carddef()
    thief_blackjack_carddef()
    thief_distracted_exchange_carddef()
    thief_enchanted_garrote_carddef()
    thief_heist_carddef()
    thief_jewelers_loupe_carddef()
    thief_keen_throwing_knife_carddef()
    thief_knife_belt_carddef()
    thief_lift_carddef()
    thief_masterful_heist_carddef()
    thief_misdirection_carddef()
    thief_pickpocket_carddef()
    thief_pilfer_carddef()
    thief_practiced_heist_carddef()
    thief_sacrificial_dagger_carddef()
    thief_shadow_mask_carddef()
    thief_silent_boots_carddef()
    thief_skillful_heist_carddef()
    thief_sleight_of_hand_carddef()
    thief_smooth_heist_carddef()
    thief_swipe_carddef()
    thief_theft_carddef()
    thief_throwing_knife_carddef()
    thief_timely_heist_carddef()
    tithe_priest_carddef()
    torgen_rocksplitter_carddef()
    tyrannor__the_devourer_carddef()
    varrick__the_necromancer_carddef()
    web_jar_carddef()
    wizard_alchemist_s_stone_carddef()
    wizard_arcane_wand_carddef()
    wizard_barreling_fireball_carddef()
    wizard_blazing_staff_carddef()
    wizard_calm_channel_carddef()
    wizard_cat_familiar_carddef()
    wizard_channel_carddef()
    wizard_deep_channel_carddef()
    wizard_explosive_fireball_carddef()
    wizard_fire_blast_carddef()
    wizard_fire_staff_carddef()
    wizard_fireball_carddef()
    wizard_flame_burst_carddef()
    wizard_ignite_carddef()
    wizard_magic_mirror_carddef()
    wizard_pure_channel_carddef()
    wizard_rolling_fireball_carddef()
    wizard_runic_robes_carddef()
    wizard_scorching_fireball_carddef()
    wizard_searing_fireball_carddef()
    wizard_serene_channel_carddef()
    wizard_serpentine_staff_carddef()
    wizard_silverskull_amulet_carddef()
    wizard_soul_channel_carddef()
    wizard_spell_components_carddef()
    wizard_spellcaster_gloves_carddef()
    wolf_form_carddef()
    wolf_shaman_carddef()
    wondrous_wand_carddef()
    word_of_power_carddef()


# Card Subtypes

Card subtypes are set to allow special processing, like knives or arrows.
You may check for it using isCardType(subType)


    noStealType -- cannot be stolen by cards such as thief_heist
    knifeType
    bowType
    arrowType
    actionType
    itemType
    spellType
    chestType
    headType
    championType
    daggerType
    abilityType
    masterType
    magicArmorType
    minionType
    dragonType
    orcType
    eliteMinionType
    elfType
    coinType
    wolfType
    gemType
    monkType
    rogueType
    assassinType
    goblinType
    spearType
    shoulderType
    currencyType
    axeType
    bannerType
    toolType
    rangedWeaponType
    meleeWeaponType
    magicWeaponType
    magicAmuletType
    magicSuppliesType
    swordType
    handType
    paladinType
    scytheType
    
    wizardType
    fighterType
    clericType
    rangerType
    thiefType
    
    weaponType
    inventoryType
    instrumentType
    candleType
    elixirType
    giantType
    maceType
    mageType
    jewelryType
    vampireType
    holyRelicType
    priestType
    treasureType
    warriorType
    ogreType
    humanType
    hammerType
    curseType
    backType
    snakeType
    armType
    felineType
    staffType
    wandType
    trollType
    necromancerType
    tentacleType
    clubType
    footType
    beltType
    demonType
    garroteType
    attachmentType
    noKillType -- mark champions with this sybtype to avoid AI killing it (Redeemed Ruinos)


# Good Practices
## Revealing cards

When you reveal cards, you move them to reveal scroller.
There are two types of reveal scrollers:

- common reveal - both players can view card faces in it.
- personal reveal - only one player can view card face in it. Other player sees card back.

When you move a card to common reveal, its a good practice to let players to examine cards before moving them to next location.
To do that - use following effect.

    waitForClickEffect("Text you see", "Text your opponent sees"),

It’s also good for personal reveal, so both you and your opponent know what’s going on at the moment.

    waitForClickEffect("Top card of your deck", "Top card of opponent's deck"),


# Card examples
## Flipping skill

Barbarian Eternal Rage skill as an example.
When activated, it transforms itself into berserk variant and stays expended until next turn as transform doesn’t affect expend status of a card.

    function barbarian_eternal_rage_carddef()
    
        return createSkillDef({
            id = "barbarian_eternal_rage",
            name = "Eternal Rage",
            description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 1",
            types = { barbarianType },
            abilities = {
                createAbility({
                    id="barbarian_eternal_rage",
                    trigger = uiTrigger,
                    effect = drawCardsEffect(1).seq(addSlotToPlayerEffect(currentPlayer(), createPlayerSlot({
                        key = berserkSlotKey,
                        expiry = { neverExpiry }
                    }))).
                    seq(transformTarget("barbarian_eternal_rage_berserk").apply(selectSource())).
                    seq(fireAbilityTriggerEffect(barbarianGoneBerserkTrigger)),
                    cost = combineCosts({
                        expendCost,
                        goldCost(ifInt(isSkillNotFree(), toIntExpression(2), toIntExpression(0)))
                    }),
                    activations = multipleActivations,
                    promptType = showPrompt,
                    layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_eternal_ragev45"),
                    aiPriority = toIntExpression(-1)
                })
            },
            layoutPath = "icons/barbarian_eternal_rage",
            layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_eternal_ragev45")
        })
    end
    
    function barbarian_eternal_rage_berserk_carddef()
    
        return createSkillDef({
            id = "barbarian_eternal_rage_berserk",
            name = "Eternal Rage",
            description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 1",
            types = { barbarianType},
            abilities = {
                createAbility({
                    id = "barbarian_eternal_rage_berserk_auto_ability",
                    effect = ifElseEffect(countPlayerSlots(currentPid, berserkImmuneSlotKey).lte(0), damagePlayerEffect(currentPid, toIntExpression(1)), nullEffect()),
                    trigger = endOfTurnTrigger,
                    activations = multipleActivations,
                }),
                createAbility({
                    id = "barbarian_eternal_rage_berserk_ability",
                    trigger = uiTrigger,
                    effect = removeSlotFromPlayerEffect(currentPlayer(), berserkSlotKey).
                    seq(transformTarget("barbarian_eternal_rage").apply(selectSource())),
                    cost = combineCosts({
                        expendCost,
                        goldCost(ifInt(isSkillNotFree(), toIntExpression(2), toIntExpression(0)))
                    }),
                    activations = multipleActivations,
                    promptType = showPrompt,
                    layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_eternal_rage_berserk"),
                    aiPriority = toIntExpression(-1)
                })
            },
            layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_eternal_rage_berserk"),
            layoutPath = "icons/barbarian_eternal_rage_berserk"
        })
    end
## Class ability


    function bard_bold_saga_carddef()
        local card_name = "bard_bold_saga"
        local selector = selectLoc(centerRowLoc).Where(isChampion().And(isCardAcquirable()).And(isCardAffordable()))
        local checkSelector = selectLoc(centerRowLoc).Where(isChampion().And(isCardAcquirable())
                .And(getCardCost().lte(getPlayerGold(ownerPid).add(toIntExpression(1)))))
        local buffSelector = selectLoc(centerRowLoc).Where(isChampion())
        local buff = getCostDiscountBuff(card_name, 1, buffSelector)
    
        return createHeroAbilityDef({
            id = card_name,
            name = "Bold Saga",
            types = { bardType },
            tags = { bardGalleryCardTag },
            abilities = {
                createAbility({
                    id = card_name .. "_ability_sacrifice",
                    effect = createCardEffect(buff, currentBuffsLoc)
                            .seq(e.AcquireToTargets(
                            toStringExpression("Acquire a champion directly into play"),
                            selector,
                            CardLocEnum.InPlay,
                            { acquireIntoPLayTag, expensiveTag }
                    )),
                    cost = sacrificeSelfCost,
                    trigger = uiTrigger,
                    promptType = showPrompt,
                    filter = s.Where(isChampion()),
                    warning = "You are trying to acquire normally while Bold Saga can be used instead",
                    check = checkSelector.count().gte(1),
                    tags = { discountTag, acquireIntoPLayTag },
                    aiPriority = toIntExpression(100),
                    layout = loadLayoutData(skillsDefaultPath .. card_name)
                })
            },
            layoutPath = iconDefaultPath .. card_name,
            layout = loadLayoutData(skillsDefaultPath .. card_name)
        })
    end


## Black Spike
    local function black_spike_carddef()
        local cardLayout = createLayout({
            name = "Black Spike",
            art = "art/t_krythos_master_vampire",
            frame = "frames/coop_campaign_cardframe",
            xmlText = [[
                    <vlayout  forceheight="true">
                        <text text="Gain {combat} equal to this Spike’s {shield}." fontsize="22" />
                    </vlayout>
                ]],
            health = 0,
            isGuard = false
        })
    
        return createChampionDef({
            id="black_spike",
            name="Black Spike",
            types={ noStealType },
            acquireCost=0,
            health = 0,
            isGuard = false,
            abilities = {
                createAbility({
                    id="black_spike_ability",
                    trigger = autoTrigger,
                    effect = gainCombatEffect(selectSource().sum(getCardHealth())),
                    check = selectLoc(currentHandLoc).count().eq(0)
                }),
                sacrificeSelfOnLeavePlayAbility("black_spike_sacrifice")
            },
            layoutPath = "icons/slaughterclaw",
            layout = cardLayout
        })
    end


## Sprout Spike Skill
    local function sprout_spike_skill()
        local cardLayout = createLayout({
            name = "Sprout a Spike",
            art = "art/campaign/warinthewild/slaughterclaw_fixed",
            frame = "frames/coop_campaign_cardframe",
            text = "Instead of acquiring a card, sacrifice it and sprout a spike equal to its cost."
        })
    
        return createSkillDef({
            id = "sprout_spike",
            name = "Sprout a Spike",
            abilities = {
                createAbility({
                    id = "sprout_spike",
                    effect = incrementCounterEffect("black_spike_guard", selectLoc(loc(currentPid, discardPloc)).reverse().take(1).sum(getCardCost()))
                            .seq(sacrificeTarget().apply(selectLoc(loc(currentPid, discardPloc)).reverse().take(1)))
                            .seq(createCardEffect(black_spike_carddef(), revealLoc))
                            .seq(grantHealthTarget(getCounter("black_spike_guard")).apply(selectLoc(revealLoc)))
                            .seq(moveTarget(currentInPlayLoc).apply(selectLoc(revealLoc)))
                            .seq(resetCounterEffect("black_spike_guard")),
                    trigger = onAcquireGlobalTrigger,
                    activations = multipleActivations,
                    promptType = showPrompt,
                    tags = { gainHealthTag }
                })
            },
            layoutPath = "features/warinthewild/slaughterclaw_spike",
            layout = cardLayout
        })
    end


## Barbarian Roaring Cowl
    function barbarian_roaring_cowl_carddef()
    
        return createMagicArmorDef({
            id = "barbarian_roaring_cowl",
            name = "Roaring Cowl",
            description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 21",
            types = { barbarianType, magicArmorType, backType },
            tags = { barbarianGalleryCardTag, devCardTag },
            level = 21,
            acquireCost = 0,
            abilities = {
                createAbility({
                    id = "barbarian_roaring_cowl_ability",
                    effect = prepareTarget().apply(selectLoc(currentSkillsLoc))
                                            .seq(addSlotToPlayerEffect(controllerPid, createPlayerIntExpressionSlot(skillCostModKey, toIntExpression(-1), { endOfTurnExpiry }))),
                    cost = expendCost,
                    check = getPlayerHealth(currentPid).gte(55).And(getAbilityActivationsThisTurn().gte(1)),
                    trigger = autoTrigger,
                    activations = singleActivation,
                    tags = { drawTag }
                }),
            },
            layoutPath = "icons/barbarian_roaring_cowl_02",
            layout = loadLayoutData("layouts/barbarian/barbarian_roaring_cowl")
        })
    end

© 2024 Wise Wizard Games, LLC.

