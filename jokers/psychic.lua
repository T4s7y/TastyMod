SMODS.Joker {
  key = "psychic",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  perish_compat = true,

  config = {
    extra = {
      target_hand = "High Card"
    }
  },

  loc_txt = {
    name = "Psychic",
    text = {
      "Creates a random {C:tarot}Tarot{} card",
      "if played hand is a {C:attention}#1#{},",
      "poker hand changes every round"
    }
  },

  loc_vars = function(self, info_queue, card)
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
      return pseudorandom_element(available_hands, pseudoseed("tarot"))
    end
    return "Pair"
  end,

  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      if G.GAME.chips >= G.GAME.blind.chips then
        card.ability.extra.target_hand = self:get_random_hand()
        return {
          message = "Reset!",
          colour = G.C.FILTER
        }
      end
    end

    if context.joker_main and context.scoring_name == card.ability.extra.target_hand then
      if #G.consumeables.cards < G.consumeables.config.card_limit then
        G.E_MANAGER:add_event(Event({
          func = function()
            local tarot = create_card("Tarot", G.consumeables, nil, nil, false, true, nil, "psychic")
            tarot:add_to_deck()
            G.consumeables:emplace(tarot)
            card:juice_up(0.5, 0.5)
            play_sound("tarot1")
            return true
          end
        }))
        return {
          message = "+1",
          colour = G.C.TAROT
        }
      end
    end
  end
}
