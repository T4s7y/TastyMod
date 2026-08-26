SMODS.Consumable {
  set = "Spectral",
  key = "summon_forth",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Summon Forth",
    text = {
      "Draw all cards with an {C:attention}Orange Seal{}"
    }
  },
  cost = 0,
  can_repeat = false,

  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and G.deck and #G.deck.cards > 0
  end,

  use = function(self, card, area, copier)
    local orange_cards = {}
    for _, deck_card in ipairs(G.deck.cards) do
      if deck_card.seal == "tm_orange" then
        orange_cards[#orange_cards + 1] = deck_card
      end
    end

    if #orange_cards > 0 then
      G.E_MANAGER:add_event(Event({
        func = function()
          for _, target_card in ipairs(orange_cards) do
            draw_card(G.deck, G.hand, 100, 'up', true, target_card)
          end
          return true
        end
      }))
    end
  end
}

local end_round_ref = end_round
function end_round()
  if G.GAME.blind and G.GAME.blind.boss then
    G.E_MANAGER:add_event(Event({
      func = function()
        if #G.consumeables.cards < G.consumeables.config.card_limit then
          local has_orange_seal = false
          if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
              if c.seal == "tm_orange" then
                has_orange_seal = true
                break
              end
            end
          end

          if has_orange_seal then
            local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_summon_forth')
            card:add_to_deck()
            G.consumeables:emplace(card)
          end
        end
        return true
      end
    }))
  end

  end_round_ref()
end
