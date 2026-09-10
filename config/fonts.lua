local wezterm = require('wezterm')

return {
   -- 基础字体:所有样式(含加粗/斜体)的回退链,保证 CJK 字形有兜底。
   -- 与下方 font_rules 的 Normal 规则保持一致,避免不同样式的字体渲染不一致。
   font = wezterm.font_with_fallback({
      { family = 'JetBrainsMonoNFM Nerd Font', weight = 'Medium' },
      { family = 'Microsoft YaHei' },
   }),

   font_rules = {
      {
         intensity = 'Normal',
         italic = false,
         font = wezterm.font_with_fallback({
            { family = 'JetBrainsMonoNFM Nerd Font', weight = 'Medium' },
            { family = 'Microsoft YaHei' },
         }),
      },
   },
   font_size = 11.0, -- 初始值，DPI 自适应会覆盖

   -- 禁用缺失字形的警告
   warn_about_missing_glyphs = false,

   freetype_render_target = 'Normal',
   freetype_load_target = 'Normal',

   -- 行高和字母间距微调
   line_height = 1.05, -- 1.0 ~ 1.1 之间
   cell_width = 1.0, -- 1.0 ~ 1.05，防止字母太挤
}
