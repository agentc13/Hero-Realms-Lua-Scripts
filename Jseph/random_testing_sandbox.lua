require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

function trickster_reshuffle_effect()
    return pushTargetedEffect({
        desc = "Put X cards back in your deck, shuffle, and then draw X cards.",
        min=1,
        max=selectLoc(loc(currentPid, handPloc)).count(),
        validTargets = selectLoc(loc(currentPid, handPloc)),
        targetEffect = moveTarget(loc(currentPid, deckPloc))
            .seq(resetCounterEffect("trickster_reshuffle_card_count"))
            .seq(incrementCounterEffect("trickster_reshuffle_card_count", selectTargets().count()))
            .seq(animateShuffleDeckEffect(currentPid))
            .seq(shuffleEffect(loc(currentPid, deckPloc)))
            .seq(drawCardsEffect(s.getCounter("trickster_reshuffle_card_count")))
        })
end

function trickster_reshuffle_hand_skill()
    local cardLayout = createLayout({
            name = "Mulligan",
            art = "art/epicart/erratic_research",
            frame = "frames/alchemist_frames/alchemist_item_cardframe",
            text = "Put X cards back in your deck, shuffle, and then draw X cards."
        })
    local drawCardLayout = createLayout({
        name = "Draw Card",
        art = "art/epicart/erratic_research",
        frame = "frames/alchemist_frames/alchemist_item_cardframe",
        text = "Draw a card"
    })
    local discardRandomCardLayout = createLayout({
        name = "Discard Random Card",
        art = "art/epicart/erratic_research",
        frame = "frames/alchemist_frames/alchemist_item_cardframe",
        text = "Discard a random card (chosen by randomTarget)"
    })
    local acquireCardForFreeLayout = createLayout({
        name = "Acquire Card for Free",
        art = "art/epicart/erratic_research",
        frame = "frames/alchemist_frames/alchemist_item_cardframe",
        text = "Acquire a random card (chosen by randomTarget) for free"
    })
    card = createSkillDef({
        id = "trickster_reshuffle_skill_jseph",
        name = "Reshuffle",
        abilities = {
            createAbility({
                id = "trickster_reshuffle_ability_id_jseph",
                trigger = uiTrigger,
                promptType = showPrompt,
                layout = cardLayout,
                effect = trickster_reshuffle_effect(),
                cost = noCost,
                check = selectLoc(loc(currentPid, handPloc)).count()
                    .gte(const(1)),
                activations = multipleActivations,
            }),
            createAbility({
                id = "trickster_reshuffle_draw_a_card",
                trigger = uiTrigger,
                promptType = showPrompt,
                layout = drawCardLayout,
                effect = drawCardsEffect(const(1)),
                cost = noCost,
                activations = multipleActivations,
            }),
            createAbility({
                id = "trickster_reshuffle_discard_a_card",
                trigger = uiTrigger,
                promptType = showPrompt,
                layout = discardRandomCardLayout,
                effect = randomTarget(
                    const(1), moveTarget(loc(currentPid, discardPloc))
                ).apply(selectLoc(currentHandLoc)),
                cost = noCost,
                activations = multipleActivations,
            }),
            createAbility({
                id = "trickster_reshuffle_acquire_a_card_for_free",
                trigger = uiTrigger,
                promptType = showPrompt,
                layout = acquireCardForFreeLayout,
                effect = randomTarget(
                    const(1), moveTarget(loc(currentPid, discardPloc))
                ).apply(selectLoc(centerRowLoc)),
                cost = noCost,
                activations = multipleActivations,
            })
         },
        layout = cardLayout,
        layoutPath = "art/epicart/erratic_research",
    })
    return card
end

local n = 2

function n_cost_card_carddef(i)
    local layout = createLayout({
        name = "Card " .. i,
        art = "art/epicart/erratic_research",
        frame = "frames/alchemist_frames/alchemist_item_cardframe",
        text = "Cost: " .. i .. " card"
    })
    return createItemDef({
        id = "n_cost_card_jseph_" .. i,
        name = "Card " .. i,
        abilities = {},
        acquireCost = i,
        layout = layout,
        layoutPath = "art/epicart/erratic_research",
    })
end

function shuffle_test_skill()
    local cardLayout = createLayout({
            name = "Shuffle Test",
            art = "art/epicart/erratic_research",
            frame = "frames/alchemist_frames/alchemist_item_cardframe",
            text = "Shuffle a deck of " .. n .. " cards."
        })
    -- Setup the effect to shuffle n cards into the deck
    local setup_effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)))
    for i = 1, n do
        setup_effect = setup_effect.seq(createCardEffect(n_cost_card_carddef(i), loc(currentPid, deckPloc)))
    end
    --[[local shuffle_and_count_effect = moveTarget(loc(oppPid, asidePloc)).apply(selectLoc(loc(currentPid, asidePloc)))
        .seq(moveTarget(loc(currentPid, asidePloc)).apply(selectLoc(loc(oppPid, asidePloc)).order(cardCost())))
        .seq(shuffleEffect(loc(currentPid, asidePloc)))]]
    local shuffle_and_count_effect = moveToBottomDeckTarget(true, 0).apply(selectLoc(loc(currentPid, deckPloc)).order(cardCost()))
    .seq(shuffleEffect(loc(currentPid, deckPloc)))
    for i = 1, n do
        for j = 1, n do
            shuffle_and_count_effect = shuffle_and_count_effect.seq(
                incrementCounterEffect("shuffle_test_counter (" .. i .. ", " .. j .. ")", 
                    selectLoc(loc(currentPid, deckPloc)).take(const(i)).reverse().take(const(1)).where(cardCost().eq(const(j))).count()
                )
            )
        end
    end
    -- Print results
    local print_results_effect = nullEffect()
    for i = 1, n do
        for j = 1, n do
            print_results_effect = print_results_effect.seq(
                showTextExpressionEffect(format("Result ({0}, {1}) = {2}", {i, j, getCounter("shuffle_test_counter (" .. i .. ", " .. j .. ")")}))
            )
        end
    end
    local full_effect = setup_effect
    for i = 1, 100 do
        full_effect = full_effect.seq(shuffle_and_count_effect)
    end
    full_effect = full_effect.seq(print_results_effect)

    card = createSkillDef({
        id = "shuffle_test_skill_jseph",
        name = "Shuffle Test",
        trigger = uiTrigger,
        abilities = {
            createAbility({
                id = "shuffle_test_ability_id_jseph",
                trigger = uiTrigger,
                promptType = showPrompt,
                layout = cardLayout,
                effect = full_effect,
                cost = noCost,
                check = selectLoc(loc(currentPid, handPloc)).count()
                    .gte(const(1)),
                activations = multipleActivations,
            })
         },
        activations = multipleActivations,
        cost = noCost,
        layout = cardLayout,
        layoutPath = "art/epicart/erratic_research",
    })
    return card
end


function setupGame(g)
    local cards_to_register = {}
    for i = 1, n do
        table.insert(cards_to_register, n_cost_card_carddef(i))
    end
    table.insert(cards_to_register, trickster_reshuffle_hand_skill())
    table.insert(cards_to_register, shuffle_test_skill())
	registerCards(g, cards_to_register)

    standardSetup(g, {
        description = "Random Testing Sandbox",
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
                    --fromEnv = plid1
                },
                --Uncomment the line below to make this player an AI. One note about AI, it doesnt work in online games so make sure to comment it back out before uploading
                --isAi = true,
                --This sets how many cards a player has on thier first turn (player 1 normally has only 3)
                startDraw = 3,
                health = 10,
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
					},
                    skills = {
                        trickster_reshuffle_hand_skill(),
                        shuffle_test_skill(),
                    }

                }
            },
            {
                id = plid2,
                --Uncomment the line below to make this player an AI. One note about AI, it doesnt work in online games so make sure to comment it back out before uploading
                --isAi = true,
                --This sets how many cards a player has on thier first turn (player 1 normally has only 3)
                startDraw = 5,
                health = 10,
				init = {
                    -- This is the part where the character data is imported
                    -- fromEnv = plid2
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
					},
                    skills = {
                        trickster_reshuffle_hand_skill(),
                    }
                }
            },                    
        }
    })
end


function endGame(g) -- more info on this later
end






            function setupMeta(meta)
                meta.name = "random_testing_sandbox"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/jseph/hero-realms-lua-scripts/hero-realms-lua-scripts/Jseph/random_testing_sandbox.lua"
                meta.features = {
}

            end