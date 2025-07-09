function result = generate_random_number(x, a, p)
    % 生成一个在 x 到 x+a 之间的随机整数，越靠近 x 概率越大
    % p 是几何分布的成功概率，需要满足 0 < p < 1
    % 该函数假设 a >=1
    k = 1: (a + 1); % 定义几何分布的可能取值
    pmf = (1 - p) .^ (k - 1) * p; % 计算几何分布的概率质量函数
    pmf = pmf / sum(pmf); % 归一化概率分布
    offset = randsample(k, 1, true, pmf); % 根据概率分布采样偏移量
    result = x + offset - 1; % 转换为实际的随机数
end