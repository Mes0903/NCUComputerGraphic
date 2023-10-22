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

使用 Midpoint ellipse drawing algorithm

