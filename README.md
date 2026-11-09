# Achievement Enabler

Lua-only UE4SS mod for Manor Lords. Returns `true` from `IsAchivementAllowed()` and logs every hook invocation.

Released as **1.0.0** following user testing: Steam awarded “Start the game” while the mod was installed. The supplied logs confirm registration but contain no hook-invocation messages, so that unlock does not establish that this override caused it. Native calls may bypass the reflected hook.

## Requirements

- Manor Lords **0.8.117** reflected function names.
- A compatible [UE4SS installation](https://github.com/UE4SS-RE/RE-UE4SS/releases). The local installation uses **3.0.1**.

## Install

### Vortex

Use the same **UE4SS Scripts** mod type as Free Stable Purchases. Install the packaged ZIP, enable it, and deploy.

### Manual

Extract the packaged ZIP into `<Manor Lords>/ManorLords/Binaries/Win64/ue4ss/Mods/`.

```text
Mods/
  AchievementEnabler/
    enabled.txt
    VERSION
    Scripts/
      main.lua
```

Start or restart the game. The empty `enabled.txt` enables the mod automatically.

## Test and logs

Check `ue4ss/UE4SS.log` for:

```text
[AchievementEnabler] Hook ready: /Script/SystemCore.SpecialFlags:IsAchivementAllowed ...
[AchievementEnabler] Loaded v1.0.0. Waiting for game calls; each hook invocation will be logged.
[AchievementEnabler] Hook fired #1: IsAchivementAllowed -> true
```

`Hook ready` confirms registration. `Hook fired` confirms execution; the counter increments on every call and resets on restart. Registration failures log `ERROR: Hook registration failed`.

Play normally with mods and check achievement progress or an unlock. The mod does not manually grant achievements. Successful registration or a hook call alone does not prove achievements are enabled. Existing modded-save behavior remains unverified. Every invocation is logged intentionally for this diagnostic build.

## Remove

Close the game, remove `AchievementEnabler` from the UE4SS Mods directory, and restart.

## Packages and releases

The repository root is the mod folder: `Scripts/`, `enabled.txt`, and `VERSION`, alongside this README and `.github/`. Packaging includes only the three payload files under `AchievementEnabler/`.

`VERSION` is the single source for the Lua startup version, ZIP filename, Actions artifact, Git tag, and GitHub release. Push a `VERSION` change to `main` to package and publish the matching release automatically. Versions with a suffix, such as `0.1.0-beta.1`, create prereleases. Existing releases are preserved; bump `VERSION` to publish another.

Manual **Package mod** workflow runs package the current version. Download packages from [Releases](https://github.com/RillonDodgers/manor-lords-achievement-enabler/releases) or [Actions](https://github.com/RillonDodgers/manor-lords-achievement-enabler/actions).

```sh
python .github/scripts/package.py --output-dir dist
```

## Validation

Local Lua checks cover registration, the `true` return, invocation logging, duplicate-load protection, and registration failure reporting. The installable ZIP and installed payload are checked against the repository. The user reported Steam awarding “Start the game” with the mod installed. Live hook execution and coverage of other achievements remain unverified.
