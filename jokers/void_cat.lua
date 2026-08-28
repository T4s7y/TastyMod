SMODS.Joker {
  key = "void_cat",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  config = { extra = { x_mult = 1.0, consumed_seals = 0 } },
  in_pool = function(self, args)
    if G.playing_cards then
      for _, deck_card in ipairs(G.playing_cards) do
        if deck_card.seal == "tm_void_seal" then
          return true
        end
      end
    end
    return false
  end,

  loc_txt = {
    name = "Void Cat",
    text = {
      "When acquired, consume all {C:purple}Void Seals{}",
      "from your deck and gain effects",
      "based on the number of seals consumed:",
      "{C:purple}2+ Seals:{} Spawn a random {C:legendary}Legendary Joker{}",
      "{C:purple}4+ Seals:{} Add {C:dark_edition}Negative{} to 2 random Jokers",
      "{C:purple}6+ Seals:{} Gives {X:mult,C:white}X#1#{} Mult equal to",
      "the amount of seals consumed",
      "{C:inactive}(Currently {X:mult,C:white}X#2#{} Mult){}"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    if G.P_SEALS and G.P_SEALS.tm_void_seal then
      info_queue[#info_queue + 1] = G.P_SEALS.tm_void_seal
    end


    local consumed = (card.ability and card.ability.extra and card.ability.extra.consumed_seals) or 0
    local current_xmult = (consumed >= 6) and consumed or 1.0

    return {
      vars = {
        current_xmult,
        current_xmult
      }
    }
  end,

  add_to_deck = function(self, card, from_debuff)
    if not from_debuff and G.playing_cards then
      local seals_found = 0

      for _, playing_card in ipairs(G.playing_cards) do
        if playing_card.seal == 'tm_void_seal' then
          seals_found = seals_found + 1
          playing_card:set_seal(nil, true)
        end
      end

      if seals_found > 0 then
        card:juice_up(0.8, 0.5)
        play_sound('tarot1')
        
        card.ability.extra.consumed_seals = card.ability.extra.consumed_seals + seals_found
        local total_consumed = card.ability.extra.consumed_seals

        if total_consumed >= 2 then
          G.E_MANAGER:add_event(Event({
            func = function()
              if #G.jokers.cards < G.jokers.config.card_limit then
                local legendary_joker = create_card('Joker', G.jokers, true, 1.0, nil, nil, nil, 'void_legendary')
                legendary_joker:add_to_deck()
                G.jokers:emplace(legendary_joker)
              end
              return true
            end
          }))
        end

        if total_consumed >= 4 then
          G.E_MANAGER:add_event(Event({
            func = function()
              local valid_jokers = {}
              for _, jkr in ipairs(G.jokers.cards) do
                if jkr ~= card and not jkr.edition then
                  table.insert(valid_jokers, jkr)
                end
              end

              pseudoshuffle(valid_jokers, pseudoseed('void_cat_neg'))
              for i = 1, math.min(2, #valid_jokers) do
                valid_jokers[i]:set_edition({ negative = true }, true)
              end
              return true
            end
          }))
        end

        if total_consumed >= 6 then
          card.ability.extra.x_mult = total_consumed
        end
      end
    end
  end,

  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.consumed_seals >= 6 then
      return {
        message = localize{type = 'variable', key = 'a_xmult', vars = { card.ability.extra.consumed_seals }},
        Xmult_mod = card.ability.extra.consumed_seals
      }
    end
  end
}
