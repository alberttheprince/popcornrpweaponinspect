local weaponAnimations = {
    [`GROUP_PISTOL`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_THROWN`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_SHOTGUN`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_SMG`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_RIFLE`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_SNIPER`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_MELEE`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop"
    },
    [`GROUP_MG`] = {
    dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
    anim = "fidget_med_loop"
    },
    [`GROUP_STUNGUN`] = {
        dict = "weapons@first_person@aim_idle@p_m_zero@pistol@shared@fidgets@c",
        anim = "fidget_med_loop" 
    },
}


local function playFidgetAnim()
    local ped = PlayerPedId()

    local weapon = GetSelectedPedWeapon(ped)
    local weaponGroup = GetWeapontypeGroup(weapon)
    local animData = weaponAnimations[weaponGroup]

    if not animData then return end

    local animDict = animData.dict
    local animName = animData.anim

    if not IsPedArmed(ped, 7) then return end
    if IsEntityPlayingAnim(ped, animDict, animName, 3) then return end

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
                StopAnimTask(ped, animDict, animName, 1.0)
                break
            end
            Wait(0)
        end
    end)
end

RegisterCommand("_fidgetanim", function()
    playFidgetAnim()
end, false)

RegisterKeyMapping("_fidgetanim", "Play Weapon Inspect Animation", "MOUSE_BUTTON", "MOUSE_MIDDLE")
