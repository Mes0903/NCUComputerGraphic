# CGLine

使用優化過的 Bresenham’s Line Drawing Algorithm，來源：[tinyrenderer](https://github.com/ssloy/tinyrenderer/wiki/Lesson-1:-Bresenham%E2%80%99s-Line-Drawing-Algorithm)  

如果該線 `abs(y1 - y0) > abs(x1 - x0)`，則需要將該線以 `x = y` 做鏡射，如果是由右畫到左的直線，也就是說 `x0 > x1`，則需將 `x0` 與 `x1` 交換

之後將初始 error 設為 0，迭代步長大小設為 `abs(dy) * 2`，當誤差大於 `dx` 時，再將 `error` 減 `dx*2`，這樣的設法可以避免浮點運算 

# CGCircle

用 Bresenham’s Circle Drawing Algorithm

把圓切成 8 個區域，每 45 度切一次，每次運算精度後都會在這八個區域畫一個點(使用了圓的對稱特性)，從 x 軸正方向逆時針開始，這 8 個區域畫的點的座標分別是

>  `(x, y)`、`(y, x)`、`(-y, x)`、`(-x, y)`、`(-x, -y)`、`(-y, -x)`、`(y, -x)`、`(x, -y)`    

迴圈會迭代 x，x 會初始化為 0，y 初始化為半徑長度，當 `d` 這個變數小於 0 時就將 `y` 的值往下一格

`d` 的數值我是參考這個網站設的：[Bresenham’s circle drawing algorithm](https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/)

# CGEllipse

使用 Midpoint ellipse drawing algorithm，以下翻自 [Midpoint ellipse drawing algorithm](https://www.geeksforgeeks.org/midpoint-ellipse-drawing-algorithm/)

中心點位於 $(h, k)$ 的橢圓，其標準方程為    

$$
\frac{(x-h)^2}{a^2} + \frac{(y-k)^2}{b^2} = 1,\ (a > b > 0)$$

所以我們可以透過下面這個方程式判斷一個點是不是在一個橢圓裡面    

$$
f(x, y) = r_y^2 x^2 + r_x^2 y^2 - r_x^2 r_y^2
$$

會有三種狀況

1. 如果 `f(x,y) < 0`，則 `(x,y)` 在橢圓內
2. 如果 `f(x,y) > 0`，則 `(x,y)` 在橢圓外
3. 如果 `f(x,y) = 0`，則 `(x,y)` 在橢圓上
    
在畫的時候，我們會將橢圓的象限分為四個部分，並把每個象限分為兩個區域，然後將第一象限內每個點的 `(x,y)` 投影到另外三個象限 `(-x,y)`、`(x,-y)`、`(-x,-y)` 

### 演算法

1. 假設橢圓一開始中心在 `(0,0)`，將 `x1` 初始化為 `0`，`y1` 初始化為 `r2`
2. 初始化第一個區域的精度參數 $p1_0$ 為 `r2*r2 - r1*r1*r2 + 0.25f*r1*r1`
3. 對於在第一個區域的所有 $x_k$:  
    如果 $p1_k < 0$，則 
    1. $p1_{k+1} = p1_k + 2r_y^2 x_{k+1} + r_y^2$
    2. 