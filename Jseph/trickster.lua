require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

--[[ Notes 
Good art for reshuffle art: art/epicart/erratic_research
Good art for pet monkey: art/epicart/deathbringer, art/classes/druid/nimble_fox, art/epicart/kong
Good art for stack the deck: art/t_sleight_of_hand
]]

double_or_nothing_layout = [[
<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">
       <icon text="{gold_1}" fontsize="40"/>
    </hlayout>    
    <hlayout spacing="10">	
        <text text="or
Decrease the cost of two random cards in the market by {gold_2} until your next acqusition." fontsize="20"/>
    </hlayout>
</vlayout>
]]

pet_monkey_layout = [[
<hlayout spacing="10">
  <icon text="{expend}" fontsize="50"/>
  <text text="Swap a card in the market row with the top card of the market deck" fontsize="24"/>
</hlayout>
]]

black_market_layout = [[
<vlayout forceheight="false" spacing="10">
       <text text="{gold_1}" fontsize="60"/>
       <text text="Rearrange the top 3 cards of the market deck" fontsize="24"/>
</vlayout>
]]

hidden_power_layout = [[
<vlayout spacing="6">
  <text text="Reveal the top market card.
Gain its faction and:" fontsize="18"/>
  <hlayout align="left" forcewidth="true" spacing="40">
    <vlayout forcewidth="true">
      <hlayout spacing="10">
        <text text="{guild}" fontsize="40"/>
        <text text="{gold_2} " fontsize="40"/>
      </hlayout>
      <hlayout spacing="10">
        <text text="{wild}" fontsize="40"/>
        <text text="{combat_3} " fontsize="40"/>
      </hlayout>
    </vlayout>
    <vlayout forcewidth="false">
      <hlayout spacing="10">
        <text text="{imperial}" fontsize="40"/>
        <text text="{health_5} " fontsize="40"/>
      </hlayout>
      <hlayout spacing="5">
        <text text="{necro}" fontsize="40"/>
        <text text="Sacrifice  
from discard" fontsize="18"/>
      </hlayout>
    </vlayout>
  </hlayout>
</vlayout>
]]

replace_ability_layout = [[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="50"/>
        </box>
        <box flexiblewidth="7">
            <text text="Sacrifice up to one card costing at least 1{gold} from you and your opponents discard. Replace them with the first card in the market deck of equal cost." fontsize="20" flexiblewidth="10" />
        </box>
    </hlayout>
</vlayout>
]]

local function show_choices_effect() 
    return pushChoiceEffect({
        choices = {
        {
            effect = gainGoldEffect(s.Minus(s.Const(1), s.getCounter("reshuffle_card_count")))
                .seq(gainHealthEffect(s.Minus(s.getCounter("reshuffle_card_count"), s.Const(1))))
                .seq(animateShuffleDeckEffect(currentPid))
                .seq(shuffleEffect(loc(currentPid, deckPloc)))
                .seq(drawCardsEffect(selectTargets().count())),
            layout = createLayout({
                name = "Continue",
                art = "art/t_prism_rainerpetter",
                text = format("{0}<sprite name=\"gold\">: Gain {0}<sprite name=\"health\"> and shuffle your deck then draw {1} card(s)", 
                    {s.Minus(s.getCounter("reshuffle_card_count"), s.Const(1)), 
                     getCounter("reshuffle_card_count")})
            }),
        },
    }
    })
end

local function reshuffle_effect()
    return pushTargetedEffect({
        desc = 
            "Pay X<sprite name=\"gold\"> to gain X<sprite name=\"health\">, put X+1 cards back in your deck, shuffle, and then draw X+1 cards.",
        min=1,
        max=ifInt(
            selectLoc(loc(currentPid, handPloc)).count()
                .gte(getPlayerGold(currentPid).add(const(1))),
            getPlayerGold(currentPid).add(const(1)),
            selectLoc(loc(currentPid, handPloc)).count()),
        validTargets = selectLoc(loc(currentPid, handPloc)),
        targetEffect = moveTarget(loc(currentPid, deckPloc))
            .seq(resetCounterEffect("reshuffle_card_count"))
            .seq(incrementCounterEffect("reshuffle_card_count", selectTargets().count()))
            .seq(show_choices_effect())
        })
end

local function reshuffle_hand_skill()
    local cardLayout = createLayout({
            name = "Mulligan",
            art = "art/t_prism_rainerpetter",
            frame = "frames/alchemist_frames/alchemist_item_cardframe",
            text = "<sprite name=\"expend\">: Pay X<sprite name=\"gold\"> to gain X<sprite name=\"health\"> and put X+1 cards back in your deck, shuffle, and then draw X+1 cards."
        })
	--[[local effect_chain = ignoreTarget(showTextEffect("Listing functions!"))
		for name, value in pairs(_G) do
		  if type(value) == "function" and string.find(name, "animate") ~= nil then
		    effect_chain = effect_chain.seq(ignoreTarget(waitForClickEffect(name,""))).seq(animateShuffleDeckEffect(currentPid))
		  end
		end]]
    card = createSkillDef({
        id = "reshuffle_skill_jseph",
        name = "Reshuffle",
        abilities = {
            createAbility({
                id = "reshuffle_ability_id_jseph",
                trigger = uiTrigger,
                promptType = showPrompt,
                layout = cardLayout,
                effect = reshuffle_effect(),
                cost = expendCost,
                check = selectLoc(loc(currentPid, handPloc)).count()
                    .gte(const(1)),
                activations = multipleActivations,
            })
         },
        layout = cardLayout,
        layoutPath = "art/t_prism_rainerpetter",
    })
    return card
end

local function sacrifice_from_discard_effect()
    return pushTargetedEffect({
        desc = "Sacrifice from discard.",
        min=0,
        max=1,
        validTargets = sacrificeSelector(selectLoc(currentDiscardLoc)),
        targetEffect = sacrificeTarget()
        })
end

local function switch_impl(val, cases)
    local len = #cases
    local effect = nullEffect()
    for i = len, 1, -1 do
        local c = cases[i][1]
        local e = cases[i][2]
        effect = ifElseEffect(val.where(c).count().gte(1),e,effect)
    end
    return effect
end

local function hidden_power_card_def()
    local cardLayout = createLayout({
            name = "Hidden Power",
            art = "art/epicart/reusable_knowledge",
            frame = "frames/alchemist_frames/alchemist_item_cardframe",
            xmlText = hidden_power_layout,
        })
    local kTopCardText = "Top card of the market deck."
    local add_faction = function(faction) 
        return addSlotToTarget(createFactionsSlot({faction},{leavesPlayExpiry, endOfTurnExpiry}))
            .apply(selectSource())
    end
    local kBonusEffects = {
        {isCardFaction(wildFaction), gainCombatEffect(3).seq(add_faction(wildFaction))},
        {isCardFaction(guildFaction), gainGoldEffect(2).seq(add_faction(guildFaction))},
        {isCardFaction(necrosFaction), sacrifice_from_discard_effect().seq(add_faction(necrosFaction))},
        {isCardFaction(imperialFaction), gainHealthEffect(5).seq(add_faction(imperialFaction))},
    }
    return createActionDef({
        id = "hidden_power_jseph",
        name = "Hidden Power",
        tags = {},
        types = {},
        factions = {},
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "hidden_power_ability_jseph",
                effect = noUndoEffect()
                    .seq(moveTarget(revealLoc).apply(selectLoc(tradeDeckLoc).take(1)))
                    .seq(waitForClickEffect(kTopCardText, kTopCardText))
                    .seq(switch_impl(selectLoc(revealLoc), kBonusEffects))
                    .seq(moveTarget(tradeDeckLoc).apply(selectLoc(revealLoc))),
                cost = noCost,
                trigger = onPlayTrigger,
                tags = {gainCombatTag},
                aiPriority = toIntExpression(5),
            })
        },
        layout=cardLayout,
    })
end

local function double_or_nothing_effect()
    local slot = createSlot({ 
        id = "double_or_nothing_discount", 
        expiresArray = { endOfTurnExpiry } })
    return pushChoiceEffect({
        choices = {
        {
            effect = gainGoldEffect(1),
            layout = createLayout({
                name = "Gold",
                art = "art/treasures/t_trick_dice",
                text = format("{{{0} gold}}",{1})
            }),
        },
        {
            effect = randomTarget(const(2), addSlotToTarget(slot)
                    .seq(noUndoEffect()))
                    .apply(selectLoc(centerRowLoc))
                .seq(createCardEffect(getCostDiscountBuff("Double or Nothing", 2, selectLoc(centerRowLoc).where(isCardWithSlotString("double_or_nothing_discount"))), currentBuffsLoc)),

            layout = createLayout({
                name = "Discount",
                art = "art/treasures/t_trick_dice",
                text = "Discount two random cards in the market by <sprite name=\"gold_2\"> until you acquire your next card."
            }),
        }
    }
    })
end

local function double_or_nothing_card_def()
    local cardLayout = createLayout({
            name = "Double or Nothing",
            art = "art/treasures/t_trick_dice",
            frame = "frames/alchemist_frames/alchemist_item_cardframe",
            xmlText = double_or_nothing_layout
        })
    return createActionDef({
        id = "double_or_nothing_jseph",
        name = "Double or Nothing",
        tags = {},
        types = {},
        factions = {},
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "double_or_nothing_ability_jseph",
                effect = double_or_nothing_effect(),
                cost = noCost,
                trigger = onPlayTrigger,
                tags = {gainCombatTag},
                aiPriority = toIntExpression(5),
            })
        },
        layout=cardLayout,
    })
end

local function pet_monkey_effect()
    local kMoveText = "Moving to top of market deck."
    return pushTargetedEffect({
        desc = "Select a card to swap with the top card of the market deck.",
        min=1,
        max=1,
        validTargets = selectLoc(centerRowLoc),
        targetEffect = moveTarget(revealLoc)
            .seq(waitForClickEffect(kMoveText, kMoveText))
            .seq(moveTarget(tradeDeckLoc).apply(selectLoc(revealLoc)))
            .seq(noUndoEffect())
        })
end

local function pet_monkey_card_def()
    local cardLayout = createLayout({
        name = "Pet Monkey",
        art = "art/epicart/kong",
        frame = "frames/alchemist_frames/alchemist_item_cardframe", 
        xmlText = pet_monkey_layout,
    })
    return createChampionDef({
        id = "pet_monkey_jseph",
        name = "Pet Monkey",
        types = {minionType, championType},
        acquireCost = 0,
        health = 2,
        isGuard = false,
        abilities = {
            createAbility({
                id = "pet_monkey_ability_jseph",
                trigger = uiTrigger,
                cost = expendCost,
                activations = multipleActivations,
                effect = pet_monkey_effect()})
        },
        layout = cardLayout,
    })
end

function black_market_effect()
    return moveTarget(currentRevealLoc).apply(selectLoc(tradeDeckLoc).take(3).reverse())
        .seq(noUndoEffect())
        .seq(gainGoldEffect(1))
        .seq(promptSplit({
            selector = selectLoc(currentRevealLoc),
            take = const(0), -- number of cards to take for split
            sort = const(0), -- number of cards to be sorted for ef2
            minTake = const(3), -- Number of cards for ef1
            ef1 = moveTarget(tradeDeckLoc), -- effect to be applied to cards left
            ef2 = ignoreTarget(nullEffect()), -- effect to be applied to sorted cards
            header = "Pet Monkey", -- prompt header
            description = "Rearrange the top 3 cards of the market deck.",
            rightPileDesc = "Rightmost on top.",
            pile1Name = "Top 3 cards.",
            pile2Name = "Unused.",
            eff1Tags = {  },
            eff2Tags = {  }}))
end

function black_market_card_def()
    local cardLayout = createLayout({
        name = "Black Market",
        art = "art/gold_female_white_grayscale",
        frame = "frames/alchemist_frames/alchemist_item_cardframe",
        xmlText = black_market_layout,
    })
    return createItemDef({
        id = "black_market_jseph",
        name = "Black Market",
        types = {itemType},
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "black_market_ability_jseph",
                trigger = onPlayTrigger,
                cost = noCost,
                activations = multipleActivations,
                effect = black_market_effect()})
        },
        layout = cardLayout,
    })
end

function card_in_current_discard()
    return selectTargets().exclude(selectLoc(currentDiscardLoc)).count().eq(0)
end

function sacrifice_target_and_replace(location)
    local equalValue = getCardPrintedCost().eq(selectTargets().sum(getCardPrintedCost()))
    return sacrificeTarget().apply(selectTargets())
        .seq(moveTarget(location).apply(
            selectLoc(tradeDeckLoc).take(1).where(equalValue).union(selectLoc(tradeDeckLoc).where(equalValue)).take(1)))
        .seq(noUndoEffect())
end

function stack_the_deck_effect_2(location)
    return pushTargetedEffect({
        desc = "Select the second card to sacrifice and replace.",
        min=0,
        max=1,
        validTargets = sacrificeSelector(selectLoc(location).where(getCardPrintedCost().gte(1))),
        targetEffect = ignoreTarget(sacrifice_target_and_replace(location))
    })
end

function stack_the_deck_effect()
    return pushTargetedEffect({
        desc = "Select the first card to sacrifice and replace.",
        min=0,
        max=1,
        validTargets = sacrificeSelector(
            selectLoc(loc(oppPid, discardPloc)).union(selectLoc(currentDiscardLoc))).where(getCardPrintedCost().gte(1)),
        targetEffect = ignoreTarget(
            ifElseEffect(
                card_in_current_discard(),
                sacrifice_target_and_replace(currentDiscardLoc)
                    .seq(stack_the_deck_effect_2(loc(oppPid, discardPloc))),
                sacrifice_target_and_replace(loc(oppPid, discardPloc))
                    .seq(stack_the_deck_effect_2(currentDiscardLoc))))
        })
end

function stack_the_deck_ability_def()
    local cardLayout = createLayout({
        name = "Stack The Deck",
        art = "art/t_angry_skeleton",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=replace_ability_layout
    })

    return createSkillDef({
        id = "replace_ability_jseph",
        name = "Stack The Deck",
        types = { abilityType },
        layout = cardLayout,
        layoutPath = "art/t_angry_skeleton",
        abilities = {
            createAbility({
                id = "replace_ability_ability_jseph",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = stack_the_deck_effect(),
				cost = sacrificeSelfCost,
			}),
        },
    })
end

local function chooseStart()
    return cardChoiceSelectorEffect({
        id = "SoG_Choice",
        name = "First choice",
        trigger = startOfTurnTrigger,

        upperTitle  = "Welcome! How would you like to proceed?",
        lowerTitle  = "",
-- 1.1 choice
        effectFirst = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc)).union(selectLoc(loc(currentPid, skillsPloc)).union(selectLoc(loc(currentPid, reservePloc))
			.union(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(ogreType).Or(isCardType(orcType)).Or(isCardType(elfType).Or(isCardType(dwarfType).Or(isCardType(smallfolkType)).Or(isCardType(halfDemonType)).Or(isCardType(magicArmorType)).Or(isCardName("smallfolk_hide_buff"))))))))))
            .seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc))))
            .seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
            .seq(setPlayerNameEffect("Trickster", currentPid))
            .seq(setPlayerAvatarEffect("smugglers", currentPid))
            .seq(gainMaxHealthEffect(currentPid, const(56).add(getPlayerMaxHealth(currentPid).negate())))
            .seq(gainHealthEffect(56))
            .seq(createCardEffect(reshuffle_hand_skill(), currentSkillsLoc))
			.seq(createCardEffect(stack_the_deck_ability_def(), currentSkillsLoc))
			.seq(createCardEffect(hidden_power_card_def(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(double_or_nothing_card_def(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(pet_monkey_card_def(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(longsword_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(black_market_card_def(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
            .seq(shuffleEffect(currentDeckLoc))
            .seq(sacrificeTarget().apply(selectSource()))
            .seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
            .seq(shuffleEffect(currentDeckLoc))
            .seq(ifElseEffect(
                    getTurnsPlayed(oppPid).eq(0),
                    drawCardsEffect(5),
                    drawCardsEffect(3)
                )),
        layoutFirst = createLayout({
            name = "Play as Trickster",
            art = "art/T_Storm_Siregar",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Play test Trickster v1.1." fontsize="26"/>
</hlayout>
</vlayout>
			
			]]
        }),
        -- We should reshuffle, that would be a bit more fair here but who cares for testing.
        effectSecond = sacrificeTarget().apply(selectSource()),
        layoutSecond = createLayout({
            name = "Selected class",
            art = "art/T_All_Heroes",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Play as the character you selected when setting up the game." fontsize="26"/>
</hlayout>
</vlayout>
			]] 
        }),
        turn = 1,
    })
end

function setupGame(g)
	registerCards(g, {
        reshuffle_hand_skill(),
        hidden_power_card_def(),
        double_or_nothing_card_def(),
        pet_monkey_card_def(),
        stack_the_deck_ability_def(),
	})

    standardSetup(g, {
        description = "Level 3 Trickster Class.",
        --This defines the play order, only 2 players is supported at this time
        playerOrder = { plid1, plid2 },
        --AI is optional but I always include it to have the option to test with an AI player
        --
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        --This player object contains/creates all the information about each player.
        --In this example the data is imported from the player/character (ie the class, health, and starting cards)
        players = {
            {
                id = plid1,
                init = {
                    --This is the part where the character data is imported
                    fromEnv = plid1
                },
                --Uncomment the line below to make this player an AI. One note about AI, it doesnt work in online games so make sure to comment it back out before uploading
                --isAi = true,
                --This sets how many cards a player has on thier first turn (player 1 normally has only 3)
                -- startDraw = 3,
				name = "Trickster",
                avatar = "smugglers",
                cards = {
                    --Since the starting deck cards/skills are predetermined, only buffs need to be here
					buffs = {
                        --This sets how many cards a player draws at the end of the turn, normally 5
                        drawCardsCountAtTurnEndDef(5),
                        --This handles the case where a player needs to discard a card at the start of their turn (discard effects/skills)
                        discardCardsAtTurnStartDef(),
                        --This is used to track the turn counter so the "Enrage" syste, triggers to try and end the game after the set number of turns.
						fatigueCount(40, 1, "FatigueP1"),
                        chooseStart(),
					},
                }
            },
            {
                id = plid2,
                --Uncomment the line below to make this player an AI. One note about AI, it doesnt work in online games so make sure to comment it back out before uploading
                --isAi = true,
                --This sets how many cards a player has on thier first turn (player 1 normally has only 3)
                -- startDraw = 5,
				init = {
                    --This is the part where the character data is imported
                    fromEnv = plid2
                },
                cards = {
                    --Since the starting deck cards/skills are predetermined, only buffs need to be here
					buffs = {
                        --This sets how many cards a player draws at the end of the turn, normally 5
                        drawCardsCountAtTurnEndDef(5),
                        --This handles the case where a player needs to discard a card at the start of their turn (discard effects/skills)
                        discardCardsAtTurnStartDef(),
                        --This is used to track the turn counter so the "Enrage" syste, triggers to try and end the game after the set number of turns.
						fatigueCount(40, 1, "FatigueP2"),
                        chooseStart(),
					},
                }
            },                    
        }
    })
end


function endGame(g) -- more info on this later
end





            function setupMeta(meta)
                meta.name = "trickster"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/jseph/hero-realms-lua-scripts/hero-realms-lua-scripts/Jseph/trickster.lua"
                meta.features = {
}

            end