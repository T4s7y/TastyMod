SMODS.Atlas {
  key = "tm_orange_seal",
  path = "orange_seal.png",
  px = 74,
  py = 95,
}

SMODS.Seal {
  key = "orange",
  atlas = "tm_orange_seal",
  badge_colour = HEX("FF8C00"),
  loc_txt = {
    label = "Orange Seal",
    name = "Orange Seal",
    text = {
      "Gives {C:money}+$1{}, {C:mult}+3{} Mult,",
      "and {C:chips}+20{} Chips for each card",
      "with an {C:attention}Orange Seal{} in your deck",
      "{C:inactive}(Currently {C:money}+$#1#{}, {C:mult}+#2#{} Mult, {C:chips}+#3#{} Chips)",
      "After beating the {C:attention}Boss Blind{}",
      "gain {C:spectral}Summon Forth{}"
    }
  },
  pos = { x = 0, y = 0 },

loc_vars = function(self, info_queue, card)
    if info_queue and G.P_CENTERS and G.P_CENTERS.c_tm_summon_forth then
      info_queue[#info_queue + 1] = G.P_CENTERS.c_tm_summon_forth
    end

    local seal_count = 0
    if G.playing_cards then
      for _, deck_card in ipairs(G.playing_cards) do
        if deck_card.seal == "tm_orange" then 
          seal_count = seal_count + 1
        end
      end
    end

    seal_count = math.max(1, seal_count)

    return { 
      vars = {
        1 * seal_count,  
        3 * seal_count,  
        20 * seal_count  
      } 
    }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      local seal_count = 0
      if G.playing_cards then
        for _, deck_card in ipairs(G.playing_cards) do
          if deck_card.seal == "tm_orange" then
            seal_count = seal_count + 1
          end
        end
      end

      if seal_count > 0 then
        return {
          dollars = 1 * seal_count,
          mult = 3 * seal_count,
          chips = 20 * seal_count
        }
      end
    end
  end
}
