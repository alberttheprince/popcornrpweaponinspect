local animDict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c"
local animName = "fidget_med_loop"

local function playFidgetAnim()
    local ped = PlayerPedId()

    if not IsPedArmed(ped, 4) or IsEntityPlayingAnim(ped, animDict, animName, 3) then
        return
    end

    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
    end


    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 48, 0, false, false, false)

        CreateThread(function()
        while IsEntityPlayingAnim(ped, animDict, animName, 3) do
            if IsPedShooting(ped) then
                ClearPedTasks(ped)
                break
            end
            Wait(0)
        end
    end)
end


RegisterCommand("_fidgetanim", function()
    playFidgetAnim()
end, false)

RegisterKeyMapping("_fidgetanim", "Play Fidget Animation", "MOUSE_BUTTON", "MOUSE_MIDDLE")
