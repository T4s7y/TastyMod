SMODS.Atlas {
  key = "tm_bfw",
  path = "bfw.png",
  px = 71,
  py = 95
}


SMODS.Joker {
  key = "bleed_from_within",
  atlas = "tm_bfw",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 5,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  loc_txt = {
    name = "Bleed From Within",
    text = {
      "A {C:attention}random card{} from your deck",
      "gets destroyed at the start of each round"
    }
  },
  calculate = function(self, card, context)
    if context.first_hand_drawn and G.deck and #G.deck.cards > 0 then
      local target_card = pseudorandom_element(G.deck.cards, pseudoseed("bleed"))

      if target_card then
        card:juice_up(0.8, 0.5)

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
            target_card.destroyed = true
            SMODS.calculate_context({ destroying_card = target_card })
            target_card:start_dissolve()
            for i = #G.playing_cards, 1, -1 do
              if G.playing_cards[i] == target_card then
                table.remove(G.playing_cards, i)
                break
              end
            end

            return true
          end
        }))

        return {
          message = "We all bleed!",
          colour = G.C.RED
        }
      end
    end
  end
}
