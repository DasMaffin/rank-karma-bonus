--[[ 
    TTT Karma Bonus by ULX Rank
    ---------------------------
    key: ULX rank string (e.g. "user", "vip", "admin")
    value: integer percent increase (10 = +10%)
]]--

KARMA_BONUS_BY_RANK = {
    ["user"] = 0,
    ["VIP"]  = 10,
    ["VIP+"]   = 20,
    ["VIP++"] = 30
}

-- Utility to get a player's ULX user group safely
local function GetRank(ply)
    if not IsValid(ply) then return "user" end
    return ply:GetUserGroup() or "user"
end

hook.Add("Initialize", "MyOverrideKarmaInitState", function()
    if KARMA then
        if KARMA.GiveReward then
            -- Save original if you want to call it
            local oldGiveReward = KARMA.GiveReward

            function KARMA.GiveReward(ply, reward)
                oldGiveReward(ply, reward * (1 + (KARMA_BONUS_BY_RANK[GetRank(ply)] or 0) / 100))
            end
        end
    end
end)