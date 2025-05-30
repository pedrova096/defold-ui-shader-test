components {
  id: "controller"
  component: "/main/camera/camera.script"
}
embedded_components {
  id: "camera"
  type: "camera"
  data: "aspect_ratio: 1.0\n"
  "fov: 0.7854\n"
  "near_z: 2.0\n"
  "far_z: 1000.0\n"
  "auto_aspect_ratio: 1\n"
  "orthographic_projection: 1\n"
  ""
}
