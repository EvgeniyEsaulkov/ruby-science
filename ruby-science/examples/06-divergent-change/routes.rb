get "/search", to: "utils#search", constraints: ->(req) { req.params.key?(:q) }
get "/search", to: redirect("/adv_search")
