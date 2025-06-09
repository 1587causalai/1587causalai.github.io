---
layout: post
title: "基于个体随机变量假设的分布回归方法"
date: 2025-05-06
description: "This paper proposes a distributional regression approach based on the assumption of individual random variables and introduces novel robust loss functions."
tags: [distributional regression, robust loss, machine learning, statistics]
categories: [Research, Disco]
future: true
toc:
  beginning: true
---

_这篇笔记记录了关于基于个体随机变量假设的分布回归方法以及一种新颖的鲁棒损失函数的思考。_

## 1. 核心概念与哲学基础

- **中心思想:** 超越标准的分类/回归（预测标签/单一数值），转向**分布回归 (Distributional Regression)**。
- **模型输出:** 对于每个输入数据点 $x_{i}$，模型输出定义目标变量 $Y_{i}$ 的完整概率分布的参数。例如：$Y_{i} \sim N(\mu_{i}, \sigma_{i}^{2})$。
- **独特的哲学立场 ("极端个体化"):**
  - 将每个样本 $i$ 视为一个独立的、微型的"随机现象"或"潜在总体"，完全由其特征 $x_{i}$ 定义。
  - 观测到的 $y_{i}$ 被视为来自这个**个体随机变量 $Y_{i}$ 的单次抽样**。
  - 不存在一个我们试图在传统意义上直接建模的、总体的、统一的数据生成分布 $P(Y \vert X)$。
  - **共享的是什么:** 不是总体，而是**底层的机制/规则** $f$（由参数 $\theta$ 参数化），该规则将任何 $x_{i}$ 映射到其对应分布 $Y_{i}$ 的参数。例如，$(\mu_{i}, \sigma_{i}) = f(x_{i}; \theta)$。
  - **目标:** 利用所有个体 $(x_{i}, y_{i})$ 观测数据，通过最大似然估计 (Maximum Likelihood Estimation, MLE) 学习共享规则 $f$ 及其参数 $\theta$。

## 2. 关键方法论思想：分布回归设置

- **模型架构:** 通常是一个神经网络（或其他灵活模型），具有共享的主体/主干网络和多个"头"或输出层。
- **示例 (高斯输出):** 对于输入 $x_{i}$，模型输出两个值：
  - $\hat{\mu}_{i} = f_{\mu}(x_{i}; \theta)$ (预测均值)
  - $\hat{\sigma}_{i} = \text{softplus}(f_{\sigma}(x_{i}; \theta))$ (预测标准差，通过 softplus 或 exp 确保正值)。
- **优化:** 最大化总对数似然，等价于最小化负对数似然 (Negative Log-Likelihood, NLL)：
  - $L(\theta) = \prod_{i} P(y_{i} \vert x_{i}; \theta) = \prod_{i} \text{pdf}_{N(\hat{\mu}_{i}, \hat{\sigma}_{i}^{2})}(y_{i})$
  - $NLL(\theta) = -\sum_{i} \log P(y_{i} \vert x_{i}; \theta)$
  - 对于高斯情况（忽略常数项）：
    $$NLL(\theta) \approx \sum_{i} \left[ \log(\hat{\sigma}_{i}) + \frac{(y_{i} - \hat{\mu}_{i})^{2}}{2 \hat{\sigma}_{i}^{2}} \right]$$

## 3. 关键推导：新颖的损失函数 (`Log-Abs-Error`)

- **来源:** 源于一个思想实验：当 $\sigma_{i}$ 被视为自由参数而不是由模型预测时，NLL 损失会怎样。
- **推导步骤:**
  1.  从样本 $i$ 的高斯 NLL 开始：
      $$\text{Loss}_{i} = \log(\sigma_{i}) + \frac{(y_{i} - \mu_{i})^{2}}{2 \sigma_{i}^{2}}$$
  2.  固定 $\mu_{i}$（由 $f_{\mu}(x_{i}; \theta)$ 预测），找到最小化 $\text{Loss}_{i}$ 的最优 $\sigma_{i}^{*}$。这发生在 $\frac{d \text{Loss}_{i}}{d \sigma_{i}} = \frac{1}{\sigma_{i}} - \frac{(y_{i} - \mu_{i})^{2}}{\sigma_{i}^{3}} = 0$ 时。
  3.  求解得到最优方差：$\sigma_{i}^{*2} = (y_{i} - \mu_{i})^{2}$，因此最优标准差为 $\sigma_{i}^{*} = \vert y_{i} - \mu_{i} \vert$。
  4.  将 $\sigma_{i}^{*}$ 代回样本 $i$ 的 NLL 损失：
      $$\text{Loss}_{i}( \theta, \sigma_{i}^{*}) = \log(\vert y_{i} - \mu_{i} \vert) + \frac{(y_{i} - \mu_{i})^{2}}{2(y_{i} - \mu_{i})^{2}} = \log(\vert y_{i} - \mu_{i} \vert) + \frac{1}{2}$$
  5.  对所有样本 $i$ 求和，并忽略常数项 $\frac{n}{2}$，得到**轮廓负对数似然 (profile negative log-likelihood)** 损失：
      $$\text{Loss}_{\text{profile}}(\theta) = \sum_{i=1}^{n} \log(\vert y_{i} - \mu_{i} \vert)$$
  6.  **稳定化处理:** 为防止当 $\mu_{i} = y_{i}$ 时出现 $\log(0)$，引入一个小的正常数 $\epsilon > 0$：
      $$\text{Loss}_{\text{novel}}(\theta) = \sum_{i=1}^{n} \log(\max(\vert y_{i} - \mu_{i} \vert, \epsilon))$$
- **提议:** 将此 $\text{Loss}_{\text{novel}}$ **直接**用作仅预测均值 $\mu_{i}$ 的模型的回归损失函数。

### 3.1 改进损失函数及其概率解释：与柯西分布的联系

在后续的深入思考中，我们提出一个更优化的损失函数形式：
$$ L*{\text{CauchyLike}} = \sum*{i} \log((y*{i} - \mu*{i})^{2} + \epsilon) $$
其中 $\epsilon$ 仍然是一个小的正常数，以确保数值稳定性。

这个损失函数与**柯西分布 (Cauchy Distribution)** 的最大似然估计 (MLE) 有着非常紧密的联系。回顾柯西分布的概率密度函数 (PDF)，其位置参数为 $\mu$，尺度参数为 $\gamma$：
$$ p(y \vert \mu, \gamma) = \frac{1}{\pi\gamma \left(1 + \left(\frac{y - \mu}{\gamma}\right)^{2}\right)} = \frac{\gamma}{\pi(\gamma^{2} + (y - \mu)^{2})} $$
对于单个观测 $y_{i}$，其负对数似然 (NLL) 为：
$$ NLL*{i} = -\log p(y*{i} \vert \mu*{i}, \gamma) = \log(\pi) + \log(\gamma) + \log(\gamma^{2} + (y*{i} - \mu*{i})^{2}) $$
假设残差 $(y*{i} - \mu*{i})$ 服从一个**固定尺度参数 $\gamma$** 的柯西分布（即 $\gamma$ 不依赖于 $x*{i}$ 且不通过模型学习），那么整个数据集的总 NLL 为：
$$ NLL*{\text{total}} = n(\log(\pi) + \log(\gamma)) + \sum*{i} \log(\gamma^{2} + (y*{i} - \mu*{i})^{2}) $$

**关键联系:** 如果我们将我们提出的损失函数中的 $\epsilon$ 视为固定的尺度参数平方，即 $\epsilon = \gamma^{2}$，那么：
$$ L*{\text{CauchyLike}} = \sum*{i} \log((y*{i} - \mu*{i})^{2} + \gamma^{2}) $$
可以看到， $L_{\text{CauchyLike}}$ 与 $NLL_{\text{total}}$ 中依赖于模型预测 $\mu_{i}$ 的部分完全一致，两者仅相差一个不依赖于 $\mu_{i}$ 的常数项 $n(\log(\pi) + \log(\gamma))$。

**结论:** 因此，最小化损失函数 $\sum_{i} \log((y_{i} - \mu_{i})^{2} + \epsilon)$ **在数学上等价于**：假设模型残差服从一个**固定尺度参数 $\gamma = \sqrt{\epsilon}$ 的柯西分布**，并通过最大似然估计来学习预测位置参数 $\mu_{i}$ 的模型。这为该损失函数的鲁棒性提供了坚实的概率基础，因为柯西分布是一种重尾分布，对异常值天然不敏感。在 M 估计理论中，这类损失函数也与 Welsch 或 Leclerc loss 相关。

## 4. 新颖损失函数的性质与潜力

- **梯度行为:** 对于之前的 $\text{Loss}_{\text{novel}} = \sum \log(\max(\vert y_{i} - \mu_{i} \vert, \epsilon))$，其梯度幅度约为 $1 / \vert y_{i} - \mu_{i} \vert$。
  对于改进后的 $L_{\text{CauchyLike}} = \sum \log((y_{i} - \mu_{i})^{2} + \epsilon)$，其关于 $\mu_{i}$ 的梯度为：

  $$\frac{\partial L_{\text{CauchyLike}}}{\partial \mu_{i}} = \sum_{i} \frac{-2(y_{i} - \mu_{i})}{(y_{i} - \mu_{i})^{2} + \epsilon}$$

  当 $\vert y_{i} - \mu_{i} \vert$ 远大于 $\sqrt{\epsilon}$ 时，梯度幅度近似为 $2/\vert y_{i} - \mu_{i} \vert$，仍然表现出**大误差对应小梯度**的特性。

- **由此产生的性质:**
  - **极强的鲁棒性:** 模型对大的异常值高度不敏感，因为它们对梯度更新的贡献很小。
  - **自动聚焦:** 优化过程自然地优先拟合具有中等到小误差的点（梯度最大的地方），有效地聚焦于数据中遵循一致模式的"最密集"或最"同质"的部分。它倾向于"忽略"那些显著偏离主要模式的点。
- **潜在应用:**
  - 在存在显著异常值或受污染数据的情况下进行高度鲁棒的回归。
  - 探索性数据分析，以识别和建模主要的底层结构/关系，同时自动降低噪声或次要模式的权重。
  - 可用于识别稳定的局部关系（可能是"局部因果"的线索，但需要谨慎解释——主要是以鲁棒的方式发现强相关性）。

## 5. 关键问答 / 思想实验总结

- **问：与 GAMLSS/MDN 的关系？它们和我的想法一样吗？**
  - **答：** GAMLSS/MDN 在*技术上实现*了基于 $x_{i}$ 预测分布参数 $(\mu_{i}, \sigma_{i})$ 的想法。然而，"极端个体化"（每个点都是一个独特的随机变量实例，仅共享规则 $f$）的*哲学出发点*可能是一个独特的视角，在 GAMLSS/MDN 文献中通常不被强调，后者通常将其框定为对 $P(Y \vert X)$ 的灵活建模。
- **问：在原始的分布回归设置中，仅对一个样本 $(x_{1}, y_{1})$ 使用 MLE 会发生什么？**
  - **答：** NLL 损失 $Loss = \log(\sigma_{1}) + \frac{(y_{1} - \mu_{1})^{2}}{2 \sigma_{1}^{2}}$ 仅依赖于这一点。如果模型 $f=(\mu, \sigma)$ 足够灵活，它很可能会急剧过拟合：驱动 $\mu_{1} \to y_{1}$ 和 $\sigma_{1} \to 0$，导致数值不稳定和对于任何其他输入的无用参数 $\theta$。这凸显了使用*多个样本*来约束 $\theta$ 并学习*共享规则* $f$ 的必要性。
- **问：如果 $\sigma_{i}$ 是一个自由参数（不由模型预测）会怎样？损失是什么？**
  - **答：** 如第 3 节所推导，优化掉自由的 $\sigma_{i}$ 会得到轮廓损失 $\sum \log(\vert y_{i} - \mu_{i} \vert)$。这简化了损失，但牺牲了模型基于 $x_{i}$ *预测*不确定性 ($\sigma_{i}$) 的能力。得到的 $\sigma_{i}^{*}$ 只反映了后验的残差误差，而不是先验的不确定性估计。这证明了最初预测 $\mu_{i}$ 和 $\sigma_{i}$ 的目标的合理性。
- **问：推导出的损失 $\sum \log(\max(\vert y_{i} - \mu_{i} \vert, \epsilon))$ 是一项独特的贡献吗？**
  - **答：** *数学形式*源自标准技术（轮廓似然）。然而，*提出并直接将其用作独立的鲁棒回归损失函数*可能是新颖的或至少是不常见的。其独特的性质（梯度 $\sim 1/error$）值得研究。贡献取决于彻底的分析以及与现有鲁棒方法的比较。

## 6. 独特性/贡献论点

1.  **原则性来源:** 源自 MLE/轮廓似然，而非纯粹的启发式方法。
2.  **独特机制:** 梯度行为（$\sim 1/error$）导致极强的鲁棒性和自动数据聚焦，与 L1/L2/Huber 不同。
3.  **新工具潜力:** 为鲁棒的探索性分析和核心数据模式建模提供了一种新颖的方法。

## 7. 反对论点 / 挑战 / 风险

1.  **新颖性检查:** 需要彻底的文献回顾，以确认其实质性新颖性是否超越了已知概念（轮廓似然、特定的 M 估计量）。
2.  **优化难度:** 非标准的梯度行为可能给优化稳定性、收敛性以及对 $\epsilon$ 的敏感性带来挑战。需要理论保证。
3.  **比较优势:** 必须通过严格的实验证明其相对于已建立的鲁棒回归技术的清晰、实际的优势。"不同"是不够的；需要在相关场景下证明其"更好"或具有独特的洞察力。

## 8. 与现有工作的关系

- **GAMLSS / MDN / 概率神经网络:** 为实现分布回归方面（预测多个分布参数）提供了技术框架。我们的哲学角度有所不同。
- **鲁棒统计 (Robust Statistics):** 这项工作属于鲁棒统计的范畴。需要与标准的 M 估计量（Huber, Tukey Biweight）、RANSAC、Theil-Sen 等进行比较。
- **轮廓似然 (Profile Likelihood):** 推导新颖损失时使用的数学技术。

## 9. 后续步骤 / 开放的研究问题

- **文献回顾:** 深入研究轮廓似然的应用、鲁棒损失函数、M 估计量、信息论损失。$\sum \log(\vert \text{error} \vert)$ 是否在其他地方被直接使用？
- **理论分析:** 研究新颖损失的性质：凸性、光滑性（或缺乏性）、影响函数、崩溃点、使用 SGD/Adam 的收敛性质、对 $\epsilon$ 的敏感性。
- **实验设计:**
  - 合成数据：测试对各种异常值类型（幅度、杠杆点）和噪声水平的鲁棒性。与 L1、L2、Huber 比较收敛速度和最终模型质量。
  - 真实世界数据：应用于已知包含异常值或复杂结构的数据集。评估性能和可解释性。
- **范围定义:** 明确定义该损失函数在哪些方面表现出色，哪些方面可能失败。它的局限性是什么？
- **扩展:** 这个想法能否应用于高斯分布以外的其他输出分布？
