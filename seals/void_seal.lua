SMODS.Atlas {
  key = "tm_void_seal",
  path = "void_seal.png",
  px = 74,
  py = 95
}

SMODS.Seal {
  key = "void_seal",
  atlas = "tm_void_seal",
  badge_colour = HEX("2e004f"),
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = "Void Seal",
    label = "Void Seal",
    text = {
      "{C:green}#1# in #2#{} chance to create",
      "a random {C:tarot}Tarot{} card",
      "{C:green}#1# in #3#{} chance to create",
      "a random {C:spectral}Spectral{} card when scored"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { 
      vars = { 
        G.GAME.probabilities.normal or 1, 
        2, 
        4 
      } 
    }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      if #G.consumeables.cards < G.consumeables.config.card_limit then
        if pseudorandom("tarot") < (G.GAME.probabilities.normal or 1) / 2 then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
            func = function()
              local tarot_card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, "void")
              tarot_card:add_to_deck()
              G.consumeables:emplace(tarot_card)
              G.GAME.consumeable_buffer = 0
              return true
            end
          }))
        end
      end

      if #G.consumeables.cards < G.consumeables.config.card_limit then
        if pseudorandom("spectral") < (G.GAME.probabilities.normal or 1) / 4 then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
            func = function()
              local spectral_card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "void")
              spectral_card:add_to_deck()
              G.consumeables:emplace(spectral_card)
              G.GAME.consumeable_buffer = 0
              return true
            end
          }))
        end
      end
    end
  end
}
