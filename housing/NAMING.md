# 命名约定

代码里的英文命名尽量对齐**上海房产行业术语**，避免通用英文带来的歧义。

## 核心实体

| 中文 | 代码命名 | 说明 |
|------|----------|------|
| 小区 | `Resblock` | 贝壳/链家 API 常用词（residential block），指一个封闭或半封闭的住宅楼盘，**不是** social community |
| 区 | `district` | 行政区划，如浦东、徐汇 |
| 板块 | `bizcircle` | 对齐链家 URL/API 字段（business circle），**不用** `block`（Ruby 保留语义） |
| 房源 | `Listing` | 暂未实现；将来指单套在售/成交记录 |

## Resblock 字段

| 中文 | 字段名 | 单位 / 说明 |
|------|--------|-------------|
| 小区名称 | `name` | — |
| 建成年份 | `built_year` | 年，不用 `build_year`（易与「建设行为」混淆） |
| 参考均价 | `reference_unit_price` | 元/㎡，平台挂牌参考价，非成交价 |
| 容积率 | `plot_ratio` | FAR，国际通用 |
| 绿化率 | `green_coverage_pct` | 0–100 百分比 |
| 物业费 | `management_fee_cny` | 元/㎡·月 |
| 总户数 | `total_unit_count` | 套 |
| 在售套数 | `on_market_unit_count` | 套 |
| 最近地铁站 | `nearest_metro_station` | — |
| 地铁步行距离 | `metro_walk_distance_m` | 米 |
| 来源平台 | `source_platform` | 如 `lianjia`、`beike`、`manual` |
| 平台小区 ID | `source_resblock_id` | 与 `source_platform` 联合唯一 |

## 筛选参数（`housing_filters`）

与模型字段保持一致，例如：

- `built_year_min` / `built_year_max`
- `reference_unit_price_min` / `reference_unit_price_max`
- `bizcircles`（数组）
- `min_on_market_units`

## 有意不采用的命名

| 不推荐 | 原因 |
|--------|------|
| `Community` | 英语里多指社群/社区，不是物理楼盘 |
| `block` | Ruby 语法术语 + 含义模糊 |
| `avg_unit_price` | 未说明是参考价还是成交价 |
| `green_ratio` | 未说明是百分比还是小数 |
| `property_fee` | property 在代码里常指「对象属性」 |
| `external_id` | 未说明是哪类外部 ID |
