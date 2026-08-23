# 上海二手房 · 小区维度数据采集

本工具以**小区**为决策单元：先筛出符合条件的小区 shortlist，再决定是否深入看具体房源。

## 为什么从「小区」入手

| 对比项 | 房源维度 | 小区维度（当前方案） |
|--------|----------|----------------------|
| 数据量 | 上海在售 10 万+ 条 | 符合条件的小区通常几百～几千个 |
| 核心问题 | 哪套值得看 | 哪个盘值得纳入候选 |
| 关键属性 | 楼层、朝向、装修 | 容积率、绿化率、均价、板块、房龄 |
| 采集入口 | `ershoufang` 二手房列表 | **`xiaoqu` 小区频道** |
| 维护成本 | 高（频繁上下架） | 低（小区属性变化慢） |

## 推荐数据源

### 1. 链家 / 贝壳 · 小区频道（主数据源）

- 列表页：`https://sh.lianjia.com/xiaoqu/{区}/`
- 支持筛选：**楼龄**（10 年以内 / 15 年以内）、**均价区间**、**区域**
- 列表页可拿：小区名、板块、参考均价、部分建成信息
- 详情页可拿：容积率、绿化率、物业费、总户数、建筑类型、地址

**采集策略**

1. 按目标区/板块遍历小区列表（分页）
2. 在 URL 或页面筛选器上叠加楼龄条件，减少无关数据
3. 对列表结果 upsert 到 `resblocks` 表
4. 仅对缺少容积率等字段的记录补抓详情页

### 2. 房天下 · 小区列表（交叉验证，可选）

- 列表页：`https://sh.esf.fang.com/housing/`
- 建筑年代筛选项更细：5–10 年、10–15 年等
- 可拿：建成年份、在售套数（判断市场活跃度）

### 3. 高德 / 百度地图 API（补充维度）

- 输入：小区地址或名称
- 输出：经纬度、最近地铁站、步行距离
- 建议：**一次性 enrichment**，不必每次刷新

### 4. 官方渠道（不做批量采集）

- [随申办 / 一网通办](https://zwdt.sh.gov.cn/)：单套核验，shortlist 后人工查
- [上海市房屋管理局](https://fgj.sh.gov.cn/fcjy/index.html)：宏观统计，非小区级批量数据

## 字段清单

### P0 — 列表页即可获取

- 小区名、区、板块
- 参考均价（元/㎡）
- 建成年份（或年代区间取中值）
- 在售套数（活跃度信号）
- 平台 `source_resblock_id` + 详情页 URL

### P1 — 需详情页或地图补充

- 容积率、绿化率、物业费
- 建筑类型（塔楼 / 板楼）
- 总户数、地址
- 最近地铁站 + 步行距离

### P2 — 人工或后续迭代

- 学区对口（平台标签不可靠，需人工核实）
- 实地观感、噪音、外立面维护
- 同小区近期成交价（可第二阶段从成交频道补充）

## 采集流水线

```text
1. Extract   按区/板块抓取 xiaoqu 列表页 → 存 raw HTML
2. Transform 解析小区卡片 → 标准化字段
3. Load      upsert Resblock（source_platform + source_resblock_id 去重）
4. Enrich    缺字段 → 抓详情页；有 address → 调地图 API
5. Filter    应用 filters.local.yml → 输出 shortlist
```

命名约定详见 [`housing/NAMING.md`](NAMING.md)。

## 与本项目的集成

### 筛选配置

默认条件在 `config/initializers/housing_filters.rb`，本地覆盖：

```bash
cp housing/config/filters.yml.example housing/config/filters.local.yml
# 编辑 built_year_min/max、districts 等
```

### 手动导入 CSV

适合阶段 1 快速验证，无需爬虫：

```bash
bin/rails housing:import[path/to/resblocks.csv]
```

CSV 表头示例：

```csv
name,district,bizcircle,built_year,reference_unit_price,plot_ratio,green_coverage_pct,management_fee_cny,building_type,total_unit_count,on_market_unit_count,address,source_resblock_id,source_platform,source_url,nearest_metro_station,metro_walk_distance_m,notes
```

### 自动化采集（下一阶段）

建议在 `housing/collectors/` 下用 Python 或 Ruby 实现，与 Rails 解耦：

- `lianjia_xiaoqu_list.rb` — 列表页
- `lianjia_xiaoqu_detail.rb` — 详情页
- 限速 3–8 秒/请求，原始 HTML 落盘到 `storage/housing/raw/`

## 合规提示

- 仅限**个人购房决策**使用
- 控制请求频率，避免对平台造成压力
- 平台 ToS 通常禁止自动化抓取，需自行评估风险
- 参考价仅供参考，不作为交易依据
