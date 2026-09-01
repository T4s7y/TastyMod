SMODS.Consumable {
  key = "irony",
  set = "Scraps",
  atlas = "tm_jokers", 
  pos = { x = 0, y = 0 },
  cost = 3,
  unlocked = true,
  discovered = true,

  loc_txt = {
    name = "Irony",
    text = {
      "Creates the last",
      "{C:attention}Scrap{} or {C:spectral}Spectral{} card",
      "used this run",
      "{C:attention}Irony{} excluded",
      "{X:spectral,C:white}#1#{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    local last_key = G.GAME and G.GAME.last_scrap_or_spectral
    local last_name = "None"

    if last_key and G.P_CENTERS[last_key] then
      info_queue[#info_queue + 1] = G.P_CENTERS[last_key]

      local target_center = G.P_CENTERS[last_key]
      if target_center.loc_txt and target_center.loc_txt.name then
        last_name = target_center.loc_txt.name
      elseif target_center.label then
        last_name = target_center.label
      else
        last_name = target_center.name or "Card"
      end
    end

    return { vars = { last_name } }
  end,

  use = function(self, card, area, copier)
    local target_key = G.GAME.last_scrap_or_spectral

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.4,
      func = function()
        if G.consumeables.cards and #G.consumeables.cards < G.consumeables.config.card_limit then
          play_sound("timpani")

          local new_card = create_card("Consumable", G.consumeables, nil, nil, nil, nil, target_key)
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)

          card:juice_up(0.5, 0.5)
        end
        return true
      end
    }))
  end,

  can_use = function(self, card)
    return G.GAME.last_scrap_or_spectral ~= nil 
    and G.P_CENTERS[G.GAME.last_scrap_or_spectral] ~= nil
    and #G.consumeables.cards < G.consumeables.config.card_limit
  end
}
