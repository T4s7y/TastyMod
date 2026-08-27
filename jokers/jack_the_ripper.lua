SMODS.Joker {
  key = "jack_the_ripper",
  atlas = "tm_jokers",
  loc_txt = {
    name = "Jack The Ripper",
    text = {
      "If played hand contains a {C:attention}Jack{}",
      "and a {C:attention}face card{},",
      "the Jack {C:red}kills{} the face card",
    }
  },
  config = { extra = {} },
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,

  calculate = function(self, card, context)
    if context.destroying_card and context.full_hand then
      local played = context.full_hand

      if #played == 2 then
        local c1, c2 = played[1], played[2]
        local id1, id2 = c1:get_id(), c2:get_id()
        if id1 == 14 or id2 == 14 then
          return nil
        end
        if id1 == 11 or id2 == 11 then
          local target_card = nil

          if id1 == 11 and id2 == 11 then
            target_card = c2
          elseif id1 == 11 then
            target_card = c2
          else
            target_card = c1
          end
          if context.destroying_card == target_card then
            G.E_MANAGER:add_event(Event({
              func = function()
                play_sound('slice1')
                return true
              end
            }))
            G.GAME.cards_destroyed = (G.GAME.cards_destroyed or 0) + 1
            return true
          end
        end
      end
    end
  end,
}
