require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

-- Game Setup
--=======================================================================================================
function setupGame(g)
    registerCards(g, {
    })

    standardSetup(g, {
        description = "Knights of  Balance: A Community Game Balancing Effort.",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
        players = {
            {
                id = plid1,
                --isAi = true,
                startDraw = 3,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    reserve = {
                        --{ qty = 1, card = wizard_treasure_map_carddef() }
                        --{ qty = 1, card = ranger_parrot_carddef() }
                    },
                    deck = {
                    },
                    hand = {
                        --{ qty = 1, card = thief_enchanted_garrote_carddef() },
                        --{ qty = 1, card = ranger_parrot_carddef() },
                        --{ qty = 1, card = cleric_redeemed_ruinos_carddef()},
                        --{ qty = 2, card = cleric_follower_b_carddef() },
                        --{ qty = 2, card = cleric_imperial_sailor_carddef() },
                        --{ qty = 1, card = cleric_brightstar_shield_carddef() },
                        --{ qty = 1, card = fighter_rallying_flag_carddef() },
                        --{ qty = 1, card = barbarian_disorienting_headbutt_carddef() },
                        --{ qty = 2, card = torgen_rocksplitter_carddef() },
                    },
                    discard = {
                        -- { qty = 2, card = torgen_rocksplitter_carddef() },
                        -- { qty = 2, card = cleric_follower_b_carddef() },
                        -- { qty = 1, card = cleric_follower_a_carddef() },
                        -- { qty = 1, card = cleric_veteran_follower_carddef() },
                        -- { qty = 1, card = cleric_redeemed_ruinos_carddef() },
                    },
                    skills = {
                        --{ qty = 1, card = fighter_helm_of_fury_carddef() },
                        --{ qty = 1, card = alchemist_spectrum_spectacles_carddef() }
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
                    }
                }
            },
            {
                id = plid2,
                --isAi = true,
                startDraw = 5,
                init = {
                    fromEnv = plid2
                },
                cards = {
                    reserve = {
                        --{ qty = 1, card = wizard_treasure_map_carddef() }
                        --{ qty = 1, card = ranger_parrot_carddef() }
                    },
                    deck = {
                    },
                    hand = {
                        --{ qty = 1, card = thief_enchanted_garrote_carddef() },
                        --{ qty = 1, card = ranger_light_crossbow_carddef() },
                        --{ qty = 1, card = ranger_honed_black_arrow_carddef() },
                        --{ qty = 2, card = cleric_follower_b_carddef() },
                        --{ qty = 2, card = cleric_imperial_sailor_carddef() },
                        --{ qty = 1, card = cleric_brightstar_shield_carddef() },
                        --{ qty = 1, card = sway_carddef() },
                    },
                    discard = {
                        --{ qty = 2, card = cleric_follower_b_carddef() },
                    },
                    skills = {
                        --{ qty = 1, card = cleric_shining_breastplate_carddef() },
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2"),
                    }
                }
            },            
        }
    })
end

function endGame(g)
end

function setupMeta(meta)
                meta.name = "knights_of_balance_v1"
                meta.minLevel = 13
                meta.maxLevel = 24
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/xTheC/Desktop/Git Repositories/hero-realms-lua-scripts/Knights  of Balance/knights_of_balance_v1.lua"
                meta.features = {
}

end

--Card Overrides
--=======================================================================================================
--
--Fighter
--=======================================================================================================
function fighter_rallying_flag_carddef()
    local cardLayout = createLayout({
        name = "Rallying Flag",
        art = "art/t_fighter_rallying_flag",
        frame = "frames/Warrior_CardFrame",
        cardTypeLabel = "Champion",
        isGuard = true,
        health = 1,
        types = { championType, humanType, fighterType },
        xmlText = [[<vlayout>
                        <box flexibleheight="1">
                            <tmpro text="{gold_1}   {combat_1}" fontsize="60"/>
                        </box>
                    </vlayout>]]
    })
    return createChampionDef({
        id = "fighter_rallying_flag",
        name = "Rallying Flag",
        acquireCost = 0,
        health = 1,
        isGuard = true,
        layout = cardLayout,
        types = { championType, humanType, fighterType },
        factions = {},
        abilities = {
            createAbility({
                id = "fighter_rallying_flag",
                trigger = autoTrigger,
                activations = multipleActivations,
                cost = expendCost,
                effect = gainCombatEffect(1).seq(gainGoldEffect(1))
            }),
        }
    })
end
--=========================================
function fighter_helm_of_fury_carddef()
    local cardLayout = createLayout({
        name = "Helm of Fury",
        art = "art/t_fighter_helm_of_fury",
        frame = "frames/Warrior_CardFrame",
        cardTypeLabel = "Magical Armor",
        xmlText =[[<vlayout>
                        <hlayout flexibleheight="1">
                            <box flexiblewidth="1">
                                <tmpro text="{requiresHealth_20}" fontsize="72"/>
                            </box>
                            <box flexiblewidth="7">
                                <tmpro text="If you have a guard in play,&lt;br&gt; gain {gold_1} {combat_1}" fontsize="32" />
                            </box>
                        </hlayout>
                </vlayout>
                    ]]
    })
    local guardChamps = selectLoc(loc(currentPid, inPlayPloc)).where(isGuard()).count()
    local disableHelm = disableTarget({ endOfTurnExpiry }).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardType(magicArmorType)))
    --local disableHelm = nullEffect()
    --
    return createMagicArmorDef({
        id = "fighter_helm_of_fury",
        name = "Helm of Fury",
        types = {fighterType, magicArmorType, treasureType, headType},
        layout = cardLayout,
        layoutPath = "icons/fighter_helm_of_fury",
        abilities = {
                createAbility({
                    id = "helmGuard",
                    trigger = autoTrigger,
                    check = minHealthCurrent(20).And(guardChamps.gte(1)),
                    effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(disableHelm)
                }),
                createAbility({
                    id = "helmLateGuard",
                    trigger = onPlayTrigger,
                    activations = singleActivation,
                    check = minHealthCurrent(20),
                    effect = ifElseEffect(guardChamps.gte(1),
                                            gainCombatEffect(1).seq(gainGoldEffect(1)).seq(disableHelm),
                                            nullEffect()) 
                }),
                createAbility({
                    id = "helmHeal",
                    trigger = gainedHealthTrigger,
                    activations = singleActivation,
                    check = minHealthCurrent(20),
                    effect = ifElseEffect(guardChamps.gte(1),
                                            gainCombatEffect(1).seq(gainGoldEffect(1)).seq(disableHelm),
                                            nullEffect()) 
                })
        }        
    })
end

--Wizard
--=======================================================================================================
function wizard_treasure_map_carddef()
    local cardLayout = createLayout({
        name = "Treasure Map",
        art = "art/treasures/t_treasure_map",
        frame = "frames/Wizard_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <tmpro text="Reserve 1" fontsize="16" flexibleheight="0.5"/>
                    <tmpro text="{gold_1}" fontsize="28" flexibleheight="0.8" flexiblewidth="3"/>
                    <divider/>
                    <hlayout flexibleheight="1">
                        <tmpro text="{imperial}" fontsize="36" flexiblewidth="3"/>
                        <tmpro text="&lt;cspace=0.3em&gt;{health_4}&lt;/cspace&gt;" fontsize="36" flexiblewidth="8" />
                        <tmpro text="{guild}" fontsize="36" flexiblewidth="5"/>
                        <tmpro text="&lt;cspace=0.5em&gt;{gold_2}&lt;/cspace&gt;" fontsize="36" flexiblewidth="8" />
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="1">

                        <tmpro text="{wild}" fontsize="36" flexiblewidth="3"/>
                        <tmpro text="Draw a card then discard a card.&lt;/cspace&gt;" fontsize="14" flexiblewidth="7" />
                        <tmpro text="{necro}" fontsize="36" flexiblewidth="5"/>
                        <tmpro text="Sacrifice 1 card in hand or discard.&lt;/cspace&gt;" fontsize="14" flexiblewidth="7" />
                    </hlayout>
                </vlayout>]]
    })
    --
    return createItemDef({
        id = "wizard_treasure_map",
        name = "Treasure Map",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, wizardType, reserveType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
                    id = "mapMain",
                    trigger = autoTrigger,
                    effect = gainGoldEffect(1),
                }),
                createAbility({
                    id = "mapUI",
                    trigger = uiTrigger,
                    activations = multipleActivations,
                    check = hasPlayerSlot(currentPid, "mapNecro").Or(hasPlayerSlot(currentPid, "mapWild")),
                    effect = pushChoiceEffect({
                                        choices={
                                            {
                                                effect = pushTargetedEffect({
                                                                    desc="Sacrifice a card in your hand or discard pile.",
                                                                    min=0,
                                                                    max=1,
                                                                    validTargets = selectLoc(loc(currentPid, discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
                                                                    targetEffect = sacrificeTarget(),
                                                                 }).seq(removeSlotFromPlayerEffect(currentPid, "mapNecro")),                
                                                layout = layoutCard({
                                                    title = "Necros",
                                                    art = "art/treasures/t_treasure_map",
                                                    text = "<sprite name=\"necro\"> Scrap a card in your hand or discard pile.",
                                                }),
                                                condition = hasPlayerSlot(currentPid, "mapNecro")                         
                                            },
                                            {
                                                effect = drawCardsEffect(1)
                                                            .seq(pushTargetedEffect({
                                                                    desc = "Discard a card.",
                                                                    min = 1,
                                                                    max = 1,
                                                                    validTargets = selectLoc(loc(currentPid, handPloc)),
                                                                    targetEffect = discardTarget(),
                                                                    }))
                                                                    .seq(removeSlotFromPlayerEffect(currentPid, "mapWild")),              
                                                layout = layoutCard({
                                                    title = "Wild",
                                                    art = "art/treasures/t_treasure_map",
                                                    text = "<sprite name=\"wild\"> Draw a card, then discard a card.",
                                                }),
                                                condition = hasPlayerSlot(currentPid, "mapWild")
                                            }
                                        }
                                    }),
                }),
                createAbility({
                    id = "necrosMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {necrosFaction},
                    effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "mapNecro", expiry = { endOfTurnExpiry } })),
                }),
                createAbility({
                    id = "guildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {guildFaction},
                    effect = gainGoldEffect(2)
                }),
                createAbility({
                    id = "wildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {wildFaction},
                    effect = addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "mapWild", expiry = { endOfTurnExpiry } })),                      
                }),
                createAbility({
                    id = "impMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {imperialFaction},
                    effect = gainHealthEffect(4)
                })
            }
    })
end

--Ranger
--=======================================================================================================
function ranger_honed_black_arrow_carddef()
    local cardLayout = createLayout({
        name = "Honed Black Arrow",
        art = "art/t_ranger_honed_black_arrow",
        frame = "frames/Ranger_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="2">
                            <tmpro text="&lt;space=-0.3em/&gt;{combat_4}" fontsize="60" flexiblewidth="8" />
                    </hlayout>
                    <hlayout flexibleheight="3">
                            <tmpro text="If you have a bow in play, Draw a card." fontsize="28" flexiblewidth="1" />
                    </hlayout>
                </vlayout>]]
    })
    --
    local bowInPlay = selectLoc(loc(currentPid, castPloc)).where(isCardType(bowType)).count()
    --
    return createItemDef({
        id = "ranger_honed_black_arrow",
        name = "Honed Black Arrow",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, rangerType, arrowType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
					id = "ranger_honed_black_arrow_combat",
					effect =gainCombatEffect(4),
					cost = noCost,
					trigger = onPlayTrigger,
					playAllType = noPlayPlayType,
					tags = { gainCombatTag ,aiPlayAllTag }
				}),
                createAbility({
					id = "ranger_honed_black_arrow_draw",
					effect = drawCardsWithAnimation(1),
					cost = noCost,
					trigger = autoTrigger,
					activations = singleActivation,
					check = selectLoc(currentInPlayLoc).union(selectLoc(currentCastLoc)).where(isCardType(bowType)).count().gte(1),
					tags = { draw1Tag },
					aiPriority = ifInt(
						selectLoc(currentInPlayLoc).
						union(selectLoc(currentCastLoc)).
						where(isCardType(bowType)).count().gte(1), toIntExpression(300), toIntExpression(-1))
				})
                },
    })
end

--Cleric
--=======================================================================================================
function cleric_redeemed_ruinos_carddef()
    local cardLayout = createLayout({
        name = "Redeemed Ruinos",
        art = "art/t_cleric_redeemed_ruinos",
        frame = "frames/Cleric_CardFrame",
        cardTypeLabel = "Champion",
        isGuard = false,
        health = 2,
        types = { championType, noStealType, humanType, clericType, noKillType},
        xmlText = [[<vlayout forceheight="false" spacing="6">
                        <hlayout spacing="10">
                        <text text="When stunned, {health_2}." fontsize="32"/>
                        </hlayout>    
                        <divider/>
                        <hlayout forcewidth="true" spacing="10">
                            <icon text="{expend}" fontsize="52"/>
                            <vlayout  forceheight="false">
                        <icon text="{gold_1}" fontsize="46"/>
                            </vlayout>
                            <icon text=" " fontsize="20"/>
                        </hlayout>
                    </vlayout>
                    ]]
    })
    return createChampionDef({
        id = "cleric_redeemed_ruinos",
        name = "Redeemed Ruinos",
        acquireCost = 0,
        health = 2,
        isGuard = false,
        layout = cardLayout,
        factions = {},
        types = { championType, noStealType, humanType, clericType, noKillType},
        tags = {noAttackButtonTag},
        abilities = {
            createAbility({
                id = "cleric_redeemed_ruinos",
                trigger = autoTrigger,
                activations = multipleActivations,
                cost = expendCost,
                effect = gainGoldEffect(1)
            }),
            createAbility({
                id = "cleric_redeemed_ruinos_stunned",
                trigger = onStunTrigger,
                effect = healPlayerEffect(ownerPid, 2).seq(simpleMessageEffect("2 <sprite name=\"health\"> gained from Redeemed Ruinos")),
                tags = { gainHealthTag }
            })
        }
    })
end

function ruinosDrawBuff()
    return createGlobalBuff({
        id="cleric_redeemed_ruinos_stunned",
        name="Ruinos Draw",
        abilities = {
            createAbility({
                id = "ruinos_draw",
                triggerPriority = 10,
                trigger = startOfTurnTrigger,
                cost = sacrificeSelfCost,
                effect = drawCardsEffect(1)
            }),
        },
        buffDetails = createBuffDetails({
            name = "Redeemed Ruinos",
            art = "art/t_cleric_redeemed_ruinos",
            text = "Draw a card."
        })
    })
end

--=========================================
function cleric_brightstar_shield_carddef()
    local cardLayout = createLayout({
        name = "Brightstar Shield",
        art = "art/t_cleric_brightstar_shield",
        frame = "frames/Cleric_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="3">
                            <tmpro text="Draw 1.&lt;br&gt; Attach this to a friendly champion.&lt;br&gt;Prepare it and it has +2 {shield}." fontsize="20" flexiblewidth="1" />
                    </hlayout>
                </vlayout>]]
    })
    local fetchShields = moveTarget(loc(ownerPid, discardPloc)).apply(selectLoc(loc(oppPid, asidePloc)))
    -- local fetchShields = moveTarget(loc(ownerPid, discardPloc)).apply(selectLoc(loc(currentPid, asidePloc)))
                            --.seq(moveTarget(loc(ownerPid, discardPloc)).apply(selectLoc(loc(oppPid, asidePloc))))
    --
    local  oneChamp =  prepareTarget().apply(selectLoc(loc(currentPid,inPlayPloc)))
                        .seq(grantHealthTarget(2, { SlotExpireEnum.LeavesPlay }, fetchShields, "shield").apply(selectLoc(loc(currentPid,inPlayPloc))))
                        .seq(moveTarget(asidePloc).apply(selectLoc(loc(currentPid, castPloc)).where(isCardName("cleric_brightstar_shield"))))
    --
    local  multiChamp = pushTargetedEffect({
                            desc="Choose a champion to prepare and gain +2 defense from brightstar shield",
                            min=1,
                            max=1,
                            validTargets = selectLoc(loc(currentPid,inPlayPloc)).where(isCardChampion()),
                            targetEffect = prepareTarget().seq(grantHealthTarget(2, { SlotExpireEnum.LeavesPlay },fetchShields,"shield").apply(selectTargets())),
                        })
                        .seq(moveTarget(asidePloc).apply(selectLoc(loc(currentPid, castPloc)).where(isCardName("cleric_brightstar_shield"))))
    --
    local numChamps =  selectLoc(loc(currentPid,inPlayPloc)).where(isCardChampion()).count()
    --
    return createItemDef({
        id = "cleric_brightstar_shield",
        name = "Brightstar Shield",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, clericType, attachmentType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                    createAbility({
                        id = "brightMain",
                        trigger = autoTrigger,
                        playAllType = blockPlayType,
                        effect = drawCardsEffect(1).seq(ifElseEffect(numChamps.eq(0),
                                                            nullEffect(),
                                                            ifElseEffect(numChamps.eq(1),
                                                            oneChamp,
                                                            multiChamp)))
                    }),
                },
    })
end

--=========================================
function cleric_shining_breastplate_carddef()
    local card_name = "cleric_shining_breastplate"
	local cardLayout = createLayout({
        name = "Shining Breastplate",
        art = "art/t_cleric_shining_breastplate",
        frame = "frames/Cleric_CardFrame",
        cardTypeLabel = "Magical Armor",
        xmlText =[[<hlayout spacing="1" forcewidth="true">
                    <icon text="{requiresHealth_25}" fontsize="90"/>    
                    <text text="If you are at full health or have +{health} this turn,
                put a champion without a cost from your discard into play." fontsize="18"/>
                    <text text=" " fontsize="80"/>
                </hlayout>]]
    })
	local noCostChamps = selectLoc(loc(currentPid, discardPloc)).where(isCardChampion().And(getCardCost().eq(0)))
    local gainedHealthKey = "gainedHealthThisTurn"
    local gainedHealthSlot = createPlayerSlot({ key = gainedHealthKey, expiry = { endOfTurnExpiry } })
    return createMagicArmorDef({
        id = card_name,
        name = "Shining Breastplate",
        description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 9",
        acquireCost = 0,
        types = { clericType, magicArmorType, treasureType, chestType },
        tags = { clericGalleryCardTag },
        level = 9,
        abilities = {
            createAbility({
                id = card_name .. "_auto_armor_on_start_turn_ability",
                effect = pushTargetedEffect(
                    {
                        desc = "Choose a champion without a cost to put in play",
                        validTargets = noCostChamps,
                        min = 0,
                        max = 1,
                        targetEffect = moveTarget(currentInPlayLoc),
                        tags = {toughestTag}                        
                    }
                ),
                trigger = uiTrigger,
                cost = expendCost,
                check = getPlayerHealth(currentPid).eq(getPlayerMaxHealth(currentPid))
                            .Or(hasPlayerSlot(currentPlayer(), gainedHealthKey))
                            .And(noCostChamps.count().gte(1))
                            .And(getPlayerHealth(currentPid).gte(25)),
                tags = { gainCombatTag }
            }),
            createAbility({
                id = card_name .. "_track_health_gained",
                effect = showTextEffect("Congrats on the heal!").seq(
                addSlotToPlayerEffect(currentPlayer(), gainedHealthSlot)),
                trigger = gainedHealthTrigger,
                cost = noCost,
                tags = { toughestTag }
            }),
        },
        layoutPath = "icons/" .. card_name,
        layout = cardLayout
    })
end

--Thief
--=======================================================================================================
function thief_silent_boots_carddef()
    --
    local cardLayout = createLayout({
						name = "Silent Boots",
						art = "art/t_thief_silent_boots",
						frame = "frames/Thief_armor_frame",
						xmlText = [[<vlayout>
                                    <hlayout flexibleheight="1">
                                        <box flexiblewidth="1.5">
                                            <tmpro text="{requiresHealth_10}" fontsize="72"/>
                                        </box>
                                        <box flexiblewidth="7">
                                            <tmpro text="Reveal the top two cards from the market deck and sacrifice one. You may acquire the other for &lt;br&gt;1 {gold} less or put it back." fontsize="20" />
                                        </box>
                                    </hlayout>
                                </vlayout>]]
    })
    --
    local cardLayoutBuy = createLayout({
                                    name = "Silent Boots",
                                    art = "art/t_thief_silent_boots",
                                    frame = "frames/Thief_armor_frame",
                                    xmlText = [[<vlayout>
                                                    <hlayout flexibleheight="1">
                                                        <box flexiblewidth="7">
                                                            <tmpro text="Acquire for 1 {gold} less." fontsize="26" />
                                                        </box>
                                                    </hlayout>
                                                </vlayout>]]
                            })
    --
    local cardLayoutTopDeck = createLayout({
                                    name = "Silent Boots",
                                    art = "art/t_thief_silent_boots",
                                    frame = "frames/Thief_armor_frame",
                                    xmlText = [[<vlayout>
                                                    <hlayout flexibleheight="1">
                                                        <box flexiblewidth="7">
                                                            <tmpro text="Put it back on the top of the market deck." fontsize="26" />
                                                        </box>
                                                    </hlayout>
                                                </vlayout>]]
                                })
    --                            
    local effReveal =  noUndoEffect().seq(moveTarget(revealPloc).apply(selectLoc(tradeDeckLoc).take(2).reverse())
                            .seq(pushTargetedEffect({
                                    desc="Select one card to Sacrifice. The other card may be acquired for 1 less or put back on top of the market deck.",
                                    min = 1,
                                    max = 1,
                                    validTargets = selectLoc(revealLoc),
                                    targetEffect = sacrificeTarget(),
                                })))
        --
    local checkSelector = selectLoc(revealLoc).Where(isCardAcquirable().And(getCardCost().lte(getPlayerGold(currentPid).add(toIntExpression(1)))))
    --
    local effTopOrBuy = noUndoEffect().seq(pushChoiceEffect({
                                choices={
                                    {
                                        effect = acquireTarget(1,discardPloc).apply(selectLoc(revealLoc)),
                                        layout = cardLayoutBuy,
                                        condition = checkSelector.count().gte(1),                      
                                    },
                                    {
                                        effect = moveTarget(tradeDeckLoc).apply(selectLoc(revealLoc)),            
                                        layout = cardLayoutTopDeck,
                                    }
                                }
                            }))
    --
    return createMagicArmorDef({
        id = "thief_silent_boots",
        name = "Silent Boots",
        types = { magicArmorType, thiefType, feetType, treasureType },
        layout = cardLayout,
        abilities = {
            createAbility({
                id = "triggerBoots",
				trigger = uiTrigger,
                layout = cardLayout,
				promptType = showPrompt,
                check =  minHealthCurrent(10),
                effect = noUndoEffect().seq(effTopOrBuy).seq(effReveal),
        }),
    },
		layoutPath = "icons/thief_silent_boots"
    })
end

--=========================================
function thief_enchanted_garrote_carddef()
    local cardLayout = createLayout({
        name = "Enchanted Garrote",
        art = "art/t_thief_enchanted_garrote",
        frame = "frames/Thief_CardFrame",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="2.5">
                            <tmpro text="&lt;space=0.2em/&gt;{combat_1} {gold_1}" fontsize="50" flexiblewidth="8" />
                    </hlayout>
                    <hlayout flexibleheight="4">
                            <tmpro text="If you stun a champion this turn, gain {gold_1}" fontsize="20" flexiblewidth="1" />
                    </hlayout>
                </vlayout>]]
    })
    --Discard for chapions, Sacrificed for tokens
    local stunnedChamps = selectLoc(loc(oppPid, discardPloc)).union(selectLoc(loc(oppPid, sacrificePloc))).where(isCardStunned()).count()
    --
    return createItemDef({
        id = "thief_enchanted_garrote",
        name = "Enchanted Garrote",
        acquireCost = 0,
        cardTypeLabel = "Item",
        types = { itemType, noStealType, thiefType, garoteType, weaponType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {
                createAbility({
                    id = "garroteMain",
                    trigger = autoTrigger,
                    check = stunnedChamps.eq(0),
                    effect = gainCombatEffect(1).seq(gainGoldEffect(1)).seq(addSlotToPlayerEffect(currentPid, createPlayerSlot({ key = "champStunnedSlot", expiry = { endOfTurnExpiry } })))
                }),
                createAbility({
                    id = "garroteSlot",
                    trigger = autoTrigger,
                    check = hasPlayerSlot(currentPid, "champStunnedSlot").invert().And(stunnedChamps.gte(1)),
                    effect = gainCombatEffect(1).seq(gainGoldEffect(2))
                }),
                createAbility({
                    id = "garroteStun",
                    trigger = onStunGlobalTrigger,
                    activations = singleActivation,
                    effect = ifElseEffect(hasPlayerSlot(currentPid, "champStunnedSlot").And(stunnedChamps.gte(1)),
                                            gainGoldEffect(1),
                                            nullEffect()) 
                })
                },
    })
end


--Barbarian
--=======================================================================================================
function barbarian_serrated_hand_axe_carddef()
	local function isBerserk()
		return countPlayerSlots(currentPid, berserkSlotKey).gte(1)
	end
	
	local cardLayout = createLayout({
        name = "Serrated Hand Axe",
        art = "art/classes/barbarian/serrated_hand_axe",
        frame = "frames/barbarian_frames/barbarian_item_cardframe",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout>
			<hlayout flexibleheight="4">
				<vlayout padding="0,20,0,0" flexibleheight="2">
					<box flexibleheight="2">
						<tmpro text="{combat_2}" fontsize="55" />
					</box>
					<box flexibleheight="1.5">
						<tmpro text="+4 {combat} if you're Berserk." fontsize="20" />
					</box>
				</vlayout>
			</hlayout>
		</vlayout>]]
    })

    return createItemDef({
        id = "barbarian_serrated_hand_axe",
        name = "Serrated Hand Axe",
        description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 5",
        types = { barbarianType, meleeWeaponType, weaponType, axeType },
        tags = { barbarianGalleryCardTag },
        level = 5,
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "barbarian_serrated_hand_axe_ability",
                effect = gainCombatEffect(2),
                cost = noCost,
                trigger = onPlayTrigger,
                tags = { gainCombatTag,  aiPlayAllTag }
            }),
            createAbility({
                id = "barbarian_serrated_hand_axe_ability_auto",
                effect = gainCombatEffect(4),
                cost = noCost,
                activations = singleActivation,
                trigger = autoTrigger,
                check = isBerserk(),
                tags = { gainCombatTag,  aiPlayAllTag }
            }),
        },
        layout = cardLayout
    })
end

--Alchemist
--=======================================================================================================
function alchemist_spectrum_spectacles_carddef()
    local cardLayout = createLayout({
        name = "Spectrum Spectacles",
        art = "art/classes/alchemist/spectrum_spectacles",
        frame = "frames/alchemist_frames/alchemist_skill_cardframe",
        cardTypeLabel = "Magic Armor",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{imperial}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{imperial}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="{health_2}" fontsize="32" />
                        </box>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{necro}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{necro}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="{combat_2}" fontsize="32" />
                        </box>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{wild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{wild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="  Draw a card, then discard a card" fontsize="16" />
                        </box>
                    </hlayout>
                    <divider/>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{guild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{guild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="{gold_1}" fontsize="32" />
                        </box>
                    </hlayout>
                </vlayout>]]
            })

    local wildLayout = createLayout({
        name = "Spectrum Spectacles",
        art = "art/classes/alchemist/spectrum_spectacles",
        frame = "frames/alchemist_frames/alchemist_skill_cardframe",
        cardTypeLabel = "Magic Armor",
        xmlText =[[<vlayout>
                    <hlayout flexibleheight="10">
                        <box flexiblewidth="2">
                            <tmpro text="{requiresHealth_30}" fontsize="32"/>
                        </box>
                        <box flexiblewidth="2">
                            <tmpro text="{wild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="1.5">
                            <tmpro text="{wild}" fontsize="32" />
                        </box>
                        <box flexiblewidth="13">
                            <tmpro text="  Draw a card, then discard a card" fontsize="16" />
                        </box>
                    </hlayout>
                </vlayout>]]
            })

    --
    return createMagicArmorDef({
        id = "alchemist_spectrum_spectacles",
        name = "Spectrum Spectacles",
        acquireCost = 0,
        cardTypeLabel = "Magic Armor",
        types = { magicArmorType, noStealType, alchemistType},
        factions = {},
        layout = cardLayout,
        playLocation = castPloc,
            abilities = {     
                createAbility({
                    id = "impMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = { imperialFaction, imperialFaction },
                    check = minHealthCurrent(30),
                    effect = gainHealthEffect(2)
                }),
                createAbility({
                    id = "necrosMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {necrosFaction,necrosFaction},
                    check = minHealthCurrent(30),
                    effect = gainCombatEffect(2)
                }),
                createAbility({
                    id = "wildMain",
                    trigger = uiTrigger,
                    promptType = showPrompt,
                    layout = wildLayout,
                    tags = {allyTag},
                    allyFactions = {wildFaction,wildFaction},
                    check = minHealthCurrent(30),
                    effect = drawCardsEffect(1).seq(pushTargetedEffect({
                                                desc = "Discard a card.",
                                                min = 1,
                                                max = 1,
                                                validTargets = selectLoc(loc(currentPid, handPloc)),
                                                targetEffect = discardTarget(),
                                                }))                    
                }),
                 createAbility({
                    id = "guildMain",
                    trigger = autoTrigger,
                    tags = {allyTag},
                    allyFactions = {guildFaction,guildFaction},
                    check = minHealthCurrent(30),
                    effect = gainGoldEffect(1)
                }),
            }
    })
end

--Necromancer
--=======================================================================================================	
function necromancer_plague_belt_carddef()
    local card_name = "necromancer_plague_belt"
    local selector = selectLoc(currentInPlayLoc).where(isCardName("necromancer_skeleton_servant"))

	local cardLayout = createLayout({
        name = "Plague Belt",
        art = "art/classes/necromancer/plague_belt",
        frame = "frames/necromancer_frames/necromancer_skill_cardframe",
        cardTypeLabel = "Magic Armor",
        xmlText =[[<hlayout forceheight="true" spacing="10">
		<icon text="{requiresHealth_30}"
    fontsize="70"/>
	<text text="Transform a Skeleton Servant into a Skeleton Warrior." fontsize="25"/>
	<text text=" " fontsize="40"/>
	</hlayout>]]
    })
	
    return createMagicArmorDef({
        id = card_name,
        name = "Plague Belt",
        description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 9",
        acquireCost = 0,
        types = { necromancerType, magicArmorType },
        tags = { necromancerGalleryCardTag },
        level = 9,
        abilities = {
            createAbility({
                id = card_name .. "_ability",
                effect = pushTargetedEffect({
                    desc = "Choose a Skeleton Servant",
                    validTargets = selector,
                    min = 1,
                    max = 1,
                    targetEffect = transformTarget("necromancer_skeleton_warrior")
                            .seq(ignoreTarget(gainCombatEffect(selectTargets().count())))
                }),
                cost = expendCost,
                trigger = uiTrigger,
                promptType = showPrompt,
                check = getPlayerHealth(currentPid).gte(30).And(selector.count().gte(1)),
                tags = { gainCombatTag, expendTag },
                aiPriority = toIntExpression(100),
                layout = cardLayout
            })
        },
        layoutPath = "icons/necromancer/" .. card_name,
		layout = cardLayout
    })
end

--=========================================
local function isSkeletonLimitExceeded()
    return selectCurrentChampions().where(isCardType(skeletonType).And(isCardType(tokenType))).count().gte(12)
end

local function createSkeletonInPlay(card)
    return ifEffect(
            isSkeletonLimitExceeded().invert(), 
            createCardEffect(card, currentInPlayLoc)
    )
end


function necromancer_voidstone_carddef()
    local card_name = "necromancer_voidstone"
    local selector = sacrificeSelector(selectLoc(currentDiscardLoc).union(selectLoc(centerRowLoc)))

	local cardLayout = createLayout({
        name = "Voidstone",
        art = "art/classes/necromancer/voidstone",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        cardTypeLabel = "Item",
        xmlText =[[<vlayout forceheight="true" spacing="1">
		<icon text="{gold_2}" fontsize="70"/>
		<text text="You may sacrifice a card in your discard pile or the market. If you sacrifice a champion this way, put a Skeleton Warrior into play." fontsize="18"/>
		</vlayout>]]
    })
	
    return createItemDef({
        id = card_name,
        name = "Voidstone",
        description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 11",
        types = { necromancerType },
        tags = { necromancerGalleryCardTag },
        level = 11,
        acquireCost = 0,
        abilities = {
            createAbility({
                id = card_name .. "_ability_on_play",
                effect = gainGoldEffect(2).seq(pushTargetedEffect({
                    desc = "Sacrifice a card in your discard pile or in the market",
                    validTargets = selector,
                    min = 0,
                    max = 1,
                    targetEffect = ignoreTarget(ifEffect(
                            selectTargets().where(isCardChampion()).count().gte(1),
                            createSkeletonInPlay(necromancer_skeleton_warrior_carddef())))
                            .seq(sacrificeTarget())
                })),
                cost = noCost,
                trigger = onPlayTrigger,
                tags = { gainGoldTag },
                aiPriority = toIntExpression(100)
            })
        },
		layoutPath = "icons/necromancer/" .. card_name,
        layout = cardLayout
    })
end

--Bard
--=======================================================================================================	
function bard_coat_of_encores_carddef()
    local card_name = "bard_coat_of_encores"
	local cardLayout = createLayout({
        name = "Coat of Encores",
        art = "art/classes/bard/bard_coat_of_encores",
        frame = "frames/bard_frames/bard_item_cardframe",
        cardTypeLabel = "Magical Armor",
        xmlText = [[<hlayout spacing="6">
                <icon text="{requiresHealth_30}" fontsize="90"/>			
                <vlayout forceheight="true" spacing="-10">
                <text text="Discard 1.&lt;br&gt;If you do, put a Song from your deck or discard pile into your hand." fontsize="22"/>
                </vlayout>
                </hlayout>]]
    })
	local deckLayout = createLayout({
        name = "Coat of Encores",
        art = "art/classes/bard/bard_coat_of_encores",
        frame = "frames/bard_frames/bard_item_cardframe",
        text = "Put a Song from your deck into your hand."
    })
    local discardLayout = createLayout({
        name = "Coat of Encores",
        art = "art/classes/bard/bard_coat_of_encores",
        frame = "frames/bard_frames/bard_item_cardframe",
        text = "Put a Song from your discard pile into your hand."
    })
    
	local deckSelector = selectLoc(currentDeckLoc).where(isCardType(songType))
    local discardSelector = selectLoc(currentDiscardLoc).where(isCardType(songType))

    return createMagicArmorDef({
        id = card_name,
        name = "Coat of Encores",
        description = "<sprite name=\"Point\"><color=#3BF2FF><b>Available at level </b></color> 9",
        acquireCost = 0,
        types = { bardType, magicArmorType, backType },
        tags = { bardGalleryCardTag },
        level = 9,
        abilities = {
            createAbility({
                id = card_name .. "_ability",
                effect = pushTargetedEffect({
                    desc = "Discard a card to return a Song to your hand.",
                    min = 0,
                    max = 1,
                    validTargets = currentHand(),
                    targetEffect = discardTarget().seq(pushChoiceEffect({
						choices = {
							{
								effect = targeted(
										toStringExpression("Choose a Song from your discard pile to put it in your hand."),
										discardSelector,
										1,
										1,
										moveTarget(currentHandLoc),
										{ fromdiscardtohandTag }
								),
								layout = discardLayout,
								condition = discardSelector.count().gte(1)
							},
							{
								effect = targeted(
										toStringExpression("Choose a Song from your deck to put it in your hand."),
										deckSelector,
										1,
										1,
										moveTarget(currentHandLoc).seq(shuffleEffect(currentDeckLoc)).seq(animateShuffleDeckEffect(currentPlayer())),
										{ fromDeckToHandTag }
								),
								layout = deckLayout,
								condition = deckSelector.count().gte(1)
							}
						},
					}))
                }),
                cost = expendCost,
                trigger = uiTrigger,
                check = getPlayerHealth(currentPid).gte(30).And(currentHand().count().gte(1)),
                promptType = showPrompt,
                tags = { expendTag },
                aiPriority = toIntExpression(100),
                layout = cardLayout
            })
		},
        layoutPath = "icons/bard/bard_coat_of_encores",
        layout = cardLayout
    })
end 