SMODS.Atlas {
  key = "tm_alcoholic",
  path = "alcoholic.png",
  px = 71,
  py = 95
}


SMODS.Joker {
  key = "alcoholic",
  atlas = "tm_alcoholic",
  pos = { x = 0, y = 0 },
  rarity = 3, 
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  config = { 
    extra = { 
      target_hand = "[Poker hand]" 
    } 
  },

  loc_txt = {
    name = "Alcoholic",
    text = {
      "Creates a copy of {C:attention}Beer{}",
      "if {C:attention}poker hand{} is a {C:attention}#1#{},",
      "poker hand changes every round"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.j_tm_beer
    return { 
      vars = { 
        card.ability.extra.target_hand 
      } 
    }
  end,

  set_ability = function(self, card, initial, delay_sprites)
    if G.STAGE == G.STAGES.RUN then
      card.ability.extra.target_hand = self:get_random_hand()
    end
  end,

  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      if G.GAME.chips >= G.GAME.blind.chips then
        card.ability.extra.target_hand = self:get_random_hand()
      end
    end

    if context.joker_main and context.scoring_name == card.ability.extra.target_hand then
      card:juice_up(0.8, 0.5)
      local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_tm_beer')
      new_card:add_to_deck()
      G.jokers:emplace(new_card)

      return {
        message = "ANOTHER!",
        colour = G.C.RED
      }
    end
  end,

  get_random_hand = function(self)
    local available_hands = {}
    if G.GAME and G.GAME.hands then
      for hand_name, hand_data in pairs(G.GAME.hands) do
        if hand_data.visible then
          table.insert(available_hands, hand_name)
        end
      end
    end
    
    if #available_hands > 0 then
      return pseudorandom_element(available_hands, pseudoseed("alcohol"))
    end
    return "Pair"
  end
}
