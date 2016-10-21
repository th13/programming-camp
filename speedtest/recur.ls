require! ramda: R

hello-world = (times = 0) !->
  | times < 10 => do
    console.log "Hello World #{times}"
    times |> R.inc |> hello-world

hello-world!
