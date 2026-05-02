# Vaporwave Jam Game

Browser-based low poly surf game with a vaporwave / PS1-style look.

The focus is on getting Counter-Strike-style surf movement feeling good first, then layering in multiplayer, a leaderboard, and simple level-building tools. This is a 48-hour jam project, so the code should stay small, simple, and lightweight.

## Current Direction

- Frontend: raw JavaScript
- Rendering: one canvas + WebGL
- Backend: small Go relay server
- Multiplayer: client authoritative
- Visual style: low poly, PS1-inspired, no texture filtering

## Core Goal

Start with a simple handcrafted map and make the movement feel great.

For now, the main mode is:

- Time trial

Possible later directions if time allows:

- Endless run / proc gen
- Map rotation
- Exploration with collectible ramp items that let players place new ramps

## Movement

By surf, this means Counter-Strike surf style movement.

- Player uses `WASD` to provide horizontal input
- Input pushes the player into ramps
- Ramp angle redirects velocity
- When the player is on a ramp steeper than roughly 30 degrees, they enter surf mode
- In surf mode, friction should be removed or reduced as much as possible
- Movement should conserve speed well
- Additional physics substeps are likely needed

Physics feel is the top priority.

## Multiplayer

The game should support lightweight online presence.

- Other players are shown as static low poly characters
- Server relays player state between clients
- Because this is just for fun, the game is client authoritative

## Leaderboard

- Leaderboard is best time per map

## Levels

We should begin with one quick test map so we can tune movement and ramp behavior early.

Longer term, the ideal workflow is an in-game editor:

- Create a set of low poly ramps and obstacles
- Place them directly in an editor mode
- Save layouts as simple data

## Build Priorities

1. Player movement and surf physics
2. Simple test level
3. PS1 / vaporwave presentation
4. Multiplayer relay
5. Best-time leaderboard
6. In-game level editor

## Scope Rules

- Prefer simple solutions
- Avoid heavy frameworks
- Keep code readable and small
- Optimize for fast iteration during the jam
- Get the feel right before adding systems

## Deploy Notes

- Static files live in `www/`
- Nginx config lives in `nginx/vaporwave.conf`
- `deploy.sh` copies the site to `/var/www/vapor`, installs the Nginx config, tests it, and reloads Nginx
- Site is served at `http://74.208.35.96/vapor/`
