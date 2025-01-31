# tb-rpg-godot

A turn-based rpg in Godot.

# Codespace

This repo has a `devcontainer.json` for development in Github Codespaces. This codespace uses two features to enable Godot game development in a codespace: the `Desktop-Lite` feature and a custom Godot feature.

The desktop-lite feature adds a virtual desktop that you can use to edit your Godot project in the browser. The Godot feature simply adds Godot to your codespace.
In your `devcontainer.json`, you can set the Godot editor version and whether to install the dotnet and C# support. The default is `4.3-stable` and with C# support.

An example options for the godot feature in your `devcontainer.json`:

```json
"ghcr.io/lordarugula/codespace-features/godot:latest": {
    "godotVersion": "3.6-stable",
    "godotDotnet": false
}
```

Godot is installed in the directory `/opt/godot/`. Each version will be installed in its own subdirectory under the version name. For example, running Godot 4.3 without C# support:

```sh
/opt/godot/Godot_v4.3-stable_linux_x86_64/Godot_v4.3-stable_linux.x86_64 -p
```

# Limitations

The codespace may not support Vulkan, so you will have to set the render mode to Compatibility.

The codespace also does not support audio.
