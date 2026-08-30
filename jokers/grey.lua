SMODS.Atlas {
  key = "tm_grey",
  path = "grey.png",
  px = 71,
  py = 95
}


SMODS.Joker {
  key = "grey",
  atlas = "tm_grey",
  pos = { x = 0, y = 0 },
  rarity = 3, 
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perish_compat = false,

  config = { extra = { x_mult = 1.0 } },
  in_pool = function(self, args)
    if G.playing_cards then
      for _, deck_card in ipairs(G.playing_cards) do
        if deck_card.seal == "tm_grey_seal" then
          return true
        end
      end
    end
    return false
  end,
  loc_txt = {
    name = "Grey The Enormous",
    text = {
      "This joker gains {X:mult,C:white}x1{} mult",
      "for every {C:attention}Grey Seal{} in the deck",
      "{C:inactive}(Currently {X:mult,C:white}x#1#{} Mult)"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.tm_grey_seal

    local seal_count = 1
    if G.playing_cards then
      for _, deck_card in ipairs(G.playing_cards) do
        if deck_card.seal == "tm_grey_seal" then 
          seal_count = seal_count + 1
        end
      end
    end
    return { 
      vars = {
        seal_count
      } 
    }
  end,

calculate = function(self, card, context)
    if context.joker_main then
      local seal_count = 0
      if G.playing_cards then
        for _, deck_card in ipairs(G.playing_cards) do
          if deck_card.seal == "tm_grey_seal" then
            seal_count = seal_count + 1
          end
        end
      end

      local total_xmult = 1 + seal_count

      if total_xmult > 1 then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = { total_xmult }},
          Xmult_mod = total_xmult
        }
      end
    end
  end
}
