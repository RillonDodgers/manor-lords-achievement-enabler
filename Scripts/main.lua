-- Manor Lords 0.8.117 / UE4SS: diagnostic achievement eligibility override.
if AchievementEnabler and AchievementEnabler.loaded then return end
local scriptDirectory = assert(debug.getinfo(1, "S").source:match("^@(.*[\\/])"), "Cannot locate mod directory")
local versionFile = assert(io.open(scriptDirectory .. "../VERSION", "r"))
local VERSION = assert(versionFile:read("*a")):match("^%s*(.-)%s*$")
versionFile:close()

local TAG = "[AchievementEnabler] "
local TARGET = "/Script/SystemCore.SpecialFlags:IsAchivementAllowed"
local calls = 0

local function log(message)
    print(TAG .. message .. "\n")
end

local ok, preId, postId = pcall(RegisterHook, TARGET,
    function() end,
    function()
        calls = calls + 1
        log(string.format("Hook fired #%d: IsAchivementAllowed -> true", calls))
        return true
    end
)

if not ok then
    log("ERROR: Hook registration failed: " .. tostring(preId))
    return
end

AchievementEnabler = { loaded = true, version = VERSION, preId = preId, postId = postId }

log(string.format("Hook ready: %s (pre=%s, post=%s)",
    TARGET, tostring(preId), tostring(postId)))
log("Loaded v" .. VERSION .. ". Waiting for game calls; each hook invocation will be logged.")
