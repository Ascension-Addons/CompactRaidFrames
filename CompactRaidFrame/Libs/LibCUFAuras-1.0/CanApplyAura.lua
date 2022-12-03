local lib, version = LibStub("LibCUFAuras-1.0");
if ( not lib ) then error("not found LibCUFAuras-1.0") end
if ( version > 1 ) then return end

local companion        = "MOUNT";
local UnitClass        = UnitClass;
local GetSpellInfo     = GetSpellInfo;
local GetCompanionInfo = GetCompanionInfo;
local GetNumCompanions = GetNumCompanions;
local PLAYER_CLASS     = select(2, UnitClass("player"));

local function SetAuraInfo(canApplyAura, appliesOnlyYourself)
    return {
        canApplyAura = canApplyAura,
        appliesOnlyYourself = appliesOnlyYourself
    };
end

local function SafeGetSpellInfo(spellID)
    return GetSpellInfo(spellID) or ""
end


local UNIT_CAN_APPLY_AURAS = {

    --CoA
    ["BARBARIAN"] = {},
    ["CHRONOMANCER"] = {},
    ["CULTIST"] = {},
    ["DEMONHUNTER"] = {},
    ["FLESHWARDEN"] = {},
    ["GUARDIAN"] = {},
    ["MONK"] = {},
    ["NECROMANCER"] = {},
    ["PROPHET"] = {},
    ["PYROMANCER"] = {},
    ["RANGER"] = {},
    ["REAPER"] = {},
    ["SONOFARUGAL"] = {},
    ["SPIRITMAGE"] = {},
    ["STARCALLER"] = {},
    ["STORMBRINGER"] = {},
    ["SUNCLERIC"] = {},
    ["TINKER"] = {},
    ["WILDWALKER"] = {},
    ["WITCHDOCTOR"] = {},
    ["WITCHHUNTER"] = {},

    --WotLK
    ["DEATHKNIGHT"] =
        {
            [SafeGetSpellInfo(48265)] = SetAuraInfo(true, true),  -- Unholy Presence
            [SafeGetSpellInfo(48263)] = SetAuraInfo(true, true),  -- Frost Presence
            [SafeGetSpellInfo(48266)] = SetAuraInfo(true, true),  -- Blood Presence
            [SafeGetSpellInfo(45529)] = SetAuraInfo(true, true),  -- Blood Tap
            [SafeGetSpellInfo(49016)] = SetAuraInfo(true, false), -- Hysteria
        },
    ["DRUID"] =
        {
            [SafeGetSpellInfo(29166)] = SetAuraInfo(true, false), -- Innervate
            [SafeGetSpellInfo(9634)]  = SetAuraInfo(true, true),  -- Dire Bear Form
            [SafeGetSpellInfo(768)]   = SetAuraInfo(true, true),  -- Cat Form
            [SafeGetSpellInfo(48451)] = SetAuraInfo(true, false), -- Lifebloom
            [SafeGetSpellInfo(48441)] = SetAuraInfo(true, false), -- Rejuvenation
            [SafeGetSpellInfo(48443)] = SetAuraInfo(true, false), -- Regrowth
            [SafeGetSpellInfo(53251)] = SetAuraInfo(true, false), -- Wild Growth
            [SafeGetSpellInfo(61336)] = SetAuraInfo(true, true),  -- Survival Instincts
            [SafeGetSpellInfo(50334)] = SetAuraInfo(true, true),  -- Berserk
            [SafeGetSpellInfo(5229)]  = SetAuraInfo(true, true),  -- Enrage
            [SafeGetSpellInfo(22812)] = SetAuraInfo(true, true),  -- Barkskin
            [SafeGetSpellInfo(53312)] = SetAuraInfo(true, true),  -- Nature's Grasp
            [SafeGetSpellInfo(22842)] = SetAuraInfo(true, true),  -- Frenzied Regeneration
            [SafeGetSpellInfo(2893)]  = SetAuraInfo(true, false), -- Abolish Poison
        },
    ["HUNTER"] =
        {
            [SafeGetSpellInfo(5384)]  = SetAuraInfo(true, true),  -- Feign Death
            [SafeGetSpellInfo(3045)]  = SetAuraInfo(true, true),  -- Rapid Fire
            [SafeGetSpellInfo(53480)] = SetAuraInfo(true, false), -- Roar of Sacrifice
            [SafeGetSpellInfo(53271)] = SetAuraInfo(true, false), -- Master's Call
        },
    ["MAGE"] =
        {
            [SafeGetSpellInfo(43039)] = SetAuraInfo(true, true),  -- Ice Barrier
            [SafeGetSpellInfo(45438)] = SetAuraInfo(true, true),  -- Ice Block
            [SafeGetSpellInfo(42995)] = SetAuraInfo(true, false), -- Arcane Intellect
            [SafeGetSpellInfo(61316)] = SetAuraInfo(true, false), -- Dalaran Brilliance
            [SafeGetSpellInfo(43002)] = SetAuraInfo(true, false), -- Arcane Brilliance
            [SafeGetSpellInfo(43015)] = SetAuraInfo(true, false), -- Dampen Magic
            [SafeGetSpellInfo(54646)] = SetAuraInfo(true, false), -- Focus Magic
            [SafeGetSpellInfo(61024)] = SetAuraInfo(true, false), -- Dalaran Intellect
            [SafeGetSpellInfo(43012)] = SetAuraInfo(true, true),  -- Frost Ward
            [SafeGetSpellInfo(43008)] = SetAuraInfo(true, true),  -- Ice Armor
            [SafeGetSpellInfo(7301)]  = SetAuraInfo(true, true),  -- Frost Armor
            [SafeGetSpellInfo(12472)] = SetAuraInfo(true, true),  -- Icy Veins
            [SafeGetSpellInfo(43010)] = SetAuraInfo(true, true),  -- Fire Ward
            [SafeGetSpellInfo(43046)] = SetAuraInfo(true, true),  -- Molten Armor
            [SafeGetSpellInfo(43020)] = SetAuraInfo(true, true),  -- Mana Shield
            [SafeGetSpellInfo(43024)] = SetAuraInfo(true, true),  -- Mage Armor
            [SafeGetSpellInfo(66)]    = SetAuraInfo(true, true),  -- Invisibility
            [SafeGetSpellInfo(130)]   = SetAuraInfo(true, false), -- Slow Fall
            [SafeGetSpellInfo(11213)] = SetAuraInfo(true, true),  -- Arcane Concentration
            [SafeGetSpellInfo(12043)] = SetAuraInfo(true, true),  -- Presence of Mind
            [SafeGetSpellInfo(12042)] = SetAuraInfo(true, true),  -- Arcane Power
            [SafeGetSpellInfo(31579)] = SetAuraInfo(true, true),  -- Arcane Empowerment
        },
    ["PALADIN"] =
        {
            [SafeGetSpellInfo(53601)] = SetAuraInfo(true, false), -- Sacred Shield
            [SafeGetSpellInfo(53563)] = SetAuraInfo(true, false), -- Beacon of Light
            [SafeGetSpellInfo(6940)]  = SetAuraInfo(true, false), -- Hand of Sacrifice
            [SafeGetSpellInfo(64205)] = SetAuraInfo(true, true),  -- Divine Sacrifice
            [SafeGetSpellInfo(31821)] = SetAuraInfo(true, true),  -- Aura Mastery
            [SafeGetSpellInfo(642)]   = SetAuraInfo(true, true),  -- Divine Shield
            [SafeGetSpellInfo(1022)]  = SetAuraInfo(true, false), -- Hand of Protection
            [SafeGetSpellInfo(10278)] = SetAuraInfo(true, false), -- Hand of Protection
            [SafeGetSpellInfo(1044)]  = SetAuraInfo(true, false), -- Hand of Freedom
            [SafeGetSpellInfo(54428)] = SetAuraInfo(true, true),  -- Divine Plea
            [SafeGetSpellInfo(20217)] = SetAuraInfo(true, false), -- Blessing of Kings
            [SafeGetSpellInfo(25898)] = SetAuraInfo(true, false), -- Greater Blessing of Kings
            [SafeGetSpellInfo(48936)] = SetAuraInfo(true, false), -- Blessing of Wisdom
            [SafeGetSpellInfo(48938)] = SetAuraInfo(true, false), -- Greater Blessing of Wisdom
            [SafeGetSpellInfo(48932)] = SetAuraInfo(true, false), -- Blessing of Might
            [SafeGetSpellInfo(48934)] = SetAuraInfo(true, false), -- Greater Blessing of Might
            [SafeGetSpellInfo(25899)] = SetAuraInfo(true, false), -- Greater Blessing of Sanctuary
            [SafeGetSpellInfo(20911)] = SetAuraInfo(true, false), -- Blessing of Sanctuary
            [SafeGetSpellInfo(70940)] = SetAuraInfo(true, false), -- Divine Guardian
            [SafeGetSpellInfo(48952)] = SetAuraInfo(true, true),  -- Holy Shield
            [SafeGetSpellInfo(48942)] = SetAuraInfo(true, true),  -- Devotion Aura
            [SafeGetSpellInfo(54043)] = SetAuraInfo(true, true),  -- Retribution Aura
            [SafeGetSpellInfo(19746)] = SetAuraInfo(true, true),  -- Concentration Aura
            [SafeGetSpellInfo(48943)] = SetAuraInfo(true, true),  -- Shadow Resistance Aura
            [SafeGetSpellInfo(48945)] = SetAuraInfo(true, true),  -- Frost Resistance Aura
            [SafeGetSpellInfo(48947)] = SetAuraInfo(true, true),  -- Fire Resistance Aura
            [SafeGetSpellInfo(32223)] = SetAuraInfo(true, true),  -- Crusader Aura
            [SafeGetSpellInfo(31884)] = SetAuraInfo(true, true),  -- Avenging Wrath
            [SafeGetSpellInfo(54203)] = SetAuraInfo(true, false), -- Sheath of Light
            [SafeGetSpellInfo(20053)] = SetAuraInfo(true, true),  -- Vengeance
            [SafeGetSpellInfo(59578)] = SetAuraInfo(true, true),  -- The Art of War
        },
    ["PRIEST"] =
        {
            [SafeGetSpellInfo(48111)] = SetAuraInfo(true, false), -- Prayer of Mending
            [SafeGetSpellInfo(33206)] = SetAuraInfo(true, false), -- Pain Suppression
            [SafeGetSpellInfo(48068)] = SetAuraInfo(true, false), -- Renew
            [SafeGetSpellInfo(48162)] = SetAuraInfo(true, false), -- Prayer of Fortitude
            [SafeGetSpellInfo(48161)] = SetAuraInfo(true, false), -- Power Word: Fortitude
            [SafeGetSpellInfo(48066)] = SetAuraInfo(true, false), -- Power Word: Shield
            [SafeGetSpellInfo(48073)] = SetAuraInfo(true, false), -- Divine Spirit
            [SafeGetSpellInfo(48074)] = SetAuraInfo(true, false), -- Prayer of Spirit
            [SafeGetSpellInfo(48169)] = SetAuraInfo(true, false), -- Shadow Protection
            [SafeGetSpellInfo(48170)] = SetAuraInfo(true, false), -- Prayer of Shadow Protection
            [SafeGetSpellInfo(72418)] = SetAuraInfo(true, true),  -- Chilling Knowledge
            [SafeGetSpellInfo(47930)] = SetAuraInfo(true, false), -- Grace
            [SafeGetSpellInfo(10060)] = SetAuraInfo(true, true),  -- Power Infusion
            [SafeGetSpellInfo(586)]   = SetAuraInfo(true, true),  -- Fade
            [SafeGetSpellInfo(48168)] = SetAuraInfo(true, true),  -- Inner Fire
            [SafeGetSpellInfo(14751)] = SetAuraInfo(true, true),  -- Inner Focus
            [SafeGetSpellInfo(6346)]  = SetAuraInfo(true, true),  -- Fear Ward
            [SafeGetSpellInfo(64901)] = SetAuraInfo(true, false), -- Hymn of Hope
            [SafeGetSpellInfo(64904)] = SetAuraInfo(true, true),  -- Hymn of Hope
            [SafeGetSpellInfo(1706)]  = SetAuraInfo(true, false), -- Levitate
            [SafeGetSpellInfo(64843)] = SetAuraInfo(true, false), -- Divine Hymn
            [SafeGetSpellInfo(59891)] = SetAuraInfo(true, true),  -- Borrowed Time
            [SafeGetSpellInfo(552)]   = SetAuraInfo(true, false), -- Abolish Disease
            [SafeGetSpellInfo(15473)] = SetAuraInfo(true, true),  -- Shadowform
            [SafeGetSpellInfo(15286)] = SetAuraInfo(true, true),  -- Vampiric Embrace
            [SafeGetSpellInfo(49694)] = SetAuraInfo(true, true),  -- Improved Spirit Tap
            [SafeGetSpellInfo(47788)] = SetAuraInfo(true, false), -- Guardian Spirit
            [SafeGetSpellInfo(33151)] = SetAuraInfo(true, true),  -- Surge of Light
            [SafeGetSpellInfo(33151)] = SetAuraInfo(true, true),  -- Inspiration
            [SafeGetSpellInfo(7001)]  = SetAuraInfo(true, false), -- Lightwell Renew
            [SafeGetSpellInfo(27827)] = SetAuraInfo(true, true),  -- Spirit of Redemption
            [SafeGetSpellInfo(63734)] = SetAuraInfo(true, true),  -- Serendipity
            [SafeGetSpellInfo(65081)] = SetAuraInfo(true, false), -- Body and Soul
            [SafeGetSpellInfo(63944)] = SetAuraInfo(true, false), -- Renewed Hope
        },
    ["ROGUE"] =
        {
            [SafeGetSpellInfo(1784)]  = SetAuraInfo(true, true),  -- Stealth
            [SafeGetSpellInfo(31665)] = SetAuraInfo(true, true),  -- Master of Subtlety
            [SafeGetSpellInfo(26669)] = SetAuraInfo(true, true),  -- Evasion
            [SafeGetSpellInfo(11305)] = SetAuraInfo(true, true),  -- Sprint
            [SafeGetSpellInfo(26888)] = SetAuraInfo(true, true),  -- Vanish
            [SafeGetSpellInfo(36554)] = SetAuraInfo(true, true),  -- Shadowstep
            [SafeGetSpellInfo(48659)] = SetAuraInfo(true, true),  -- Feint
            [SafeGetSpellInfo(31224)] = SetAuraInfo(true, true),  -- Clock of Shadow
            [SafeGetSpellInfo(51713)] = SetAuraInfo(true, true),  -- Shadow dance
            [SafeGetSpellInfo(14177)] = SetAuraInfo(true, true),  -- Cold Blood
            [SafeGetSpellInfo(57934)] = SetAuraInfo(true, false), -- Tricks of the Trade
        },
    ["SHAMAN"] =
        {
            [SafeGetSpellInfo(49284)] = SetAuraInfo(true, false), -- Earth Shield
            [SafeGetSpellInfo(8515)]  = SetAuraInfo(true, false), -- Windfury Totem
            [SafeGetSpellInfo(8177)]  = SetAuraInfo(true, false), -- Grounding Totem
            [SafeGetSpellInfo(32182)] = SetAuraInfo(true, false), -- Heroism
            [SafeGetSpellInfo(2825)]  = SetAuraInfo(true, false), -- Bloodlust
            [SafeGetSpellInfo(61301)] = SetAuraInfo(true, false), -- Riptide
        },
    ["WARLOCK"] = {    },
    ["WARRIOR"] =
        {
            [SafeGetSpellInfo(2687)]  = SetAuraInfo(true, true),  -- Bloodrage
            [SafeGetSpellInfo(18499)] = SetAuraInfo(true, true),  -- Berserker Rage
            [SafeGetSpellInfo(12328)] = SetAuraInfo(true, true),  -- Sweeping Strikes
            [SafeGetSpellInfo(23920)] = SetAuraInfo(true, true),  -- Spell Reflection
            [SafeGetSpellInfo(871)]   = SetAuraInfo(true, true),  -- Shield Wall
            [SafeGetSpellInfo(2565)]  = SetAuraInfo(true, true),  -- Shield Block
            [SafeGetSpellInfo(55694)] = SetAuraInfo(true, true),  -- Enraged Regeneration
            [SafeGetSpellInfo(1719)]  = SetAuraInfo(true, true),  -- Recklessness
            [SafeGetSpellInfo(57522)] = SetAuraInfo(true, true),  -- Enrage
            [SafeGetSpellInfo(20230)] = SetAuraInfo(true, true),  -- Retaliation
            [SafeGetSpellInfo(46924)] = SetAuraInfo(true, true),  -- Bladestorm
            [SafeGetSpellInfo(47440)] = SetAuraInfo(true, false), -- Commanding Shout
            [SafeGetSpellInfo(47436)] = SetAuraInfo(true, false), -- Battle Shout
            [SafeGetSpellInfo(46913)] = SetAuraInfo(true, true),  -- Bloodsurge
            [SafeGetSpellInfo(12292)] = SetAuraInfo(true, true),  -- Death Wish
            [SafeGetSpellInfo(16492)] = SetAuraInfo(true, true),  -- Blood Craze
            [SafeGetSpellInfo(65156)] = SetAuraInfo(true, true),  -- Juggernaut
            [SafeGetSpellInfo(3411)]  = SetAuraInfo(true, false), -- Intervene
        },
};

if PLAYER_CLASS == "HERO" then
    local t = {}
    for _, class in pairs(UNIT_CAN_APPLY_AURAS) do
        table.append(t, class)
    end

    UNIT_CAN_APPLY_AURAS["HERO"] = t
end

lib.UNIT_CAN_APPLY_AURAS = UNIT_CAN_APPLY_AURAS;

local function SetNewCompanion(spellID)
    UNIT_CAN_APPLY_AURAS[PLAYER_CLASS][SafeGetSpellInfo(spellID)] = { canApplyAura = true,  appliesOnlyYourself = true };
end

local function Companion_Inizialization()
    for index = 1, GetNumCompanions(companion) do
        local _, _, spellID = GetCompanionInfo(companion, index);
        SetNewCompanion(spellID);
    end
end

function lib.handler:PLAYER_LOGIN()
    Companion_Inizialization();
end

function lib.handler:COMPANION_UPDATE(_, arg1)
    if ( arg1 == companion ) then
        Companion_Inizialization();
    end
end

lib.handler:RegisterEvent("COMPANION_UPDATE");
lib.handler:RegisterEvent("PLAYER_LOGIN");
