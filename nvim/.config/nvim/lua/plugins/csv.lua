-- CSV viewing (trial). To remove: delete this file, then run :Lazy clean.
return {
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = {
      view = { display_mode = "border" },
    },
  },
  {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" },
  },
}
