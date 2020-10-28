# day04

## 常用API
API(Application Programming Interface, 应用程序接口)
Math类常用方法
```java
static double abs(double a) ;///返回值为 double绝对值。  
static float abs(float a) ;//返回 float值的绝对值。  
static int abs(int a) ;//返回值为 int绝对值。  
static long abs(long a) ;//返回值为 long绝对值。  
static double acos(double a) ;///返回值的反余弦值; 返回的角度在0.0到pi的范围内。  
static int addExact(int x, int y);//返回其参数的总和，如果结果溢出int，则抛出 int 。  
static long addExact(long x, long y);//返回其参数的总和，如果结果溢出long，则抛出 long 。  
static double asin(double a) ;//返回值的正弦值; 返回角度在pi / 2到pi / 2的范围内。  
static double atan(double a) ;//返回值的反正切值; 返回角度在pi / 2到pi / 2的范围内。  
static double atan2(double y, double x) ;//返回从直角坐标（转换角度 theta x ， y ）为极坐标 （R，θ-）。  
static double cbrt(double a) ;//返回 double值的多维数据集根。  
static double ceil(double a) ;//返回大于或等于参数的最小（最接近负无穷大） double值，等于一个数学整数。  
static double copySign(double magnitude, double sign) ;//使用第二个浮点参数的符号返回第一个浮点参数。  
static float copySign(float magnitude, float sign) ;//使用第二个浮点参数的符号返回第一个浮点参数。  
static double cos(double a) ;//返回角度的三角余弦。  
static double cosh(double x) ;//返回的双曲余弦 double值。  
static int decrementExact(int a) ;//返回一个递减1的参数，如果结果溢出int，则 int 。  
static long decrementExact(long a) ;//将返回的参数递减1，如果结果溢出long，则 long 。  
static double exp(double a) ;//返回欧拉的数字 e提高到一个 double价值。  
static double expm1(double x) ;//返回 e x -1。  
static double floor(double a) ;//返回小于或等于参数的最大（最接近正无穷大） double值，等于一个数学整数。  
static int floorDiv(int x, int y) ;//返回小于或等于代数商的最大（最接近正无穷大） int值。  
static long floorDiv(long x, long y) ;//返回小于或等于代数商的最大（最接近正无穷大） long值。  
static int floorMod(int x, int y) ;//返回 int参数的底部模数。  
static long floorMod(long x, long y) ;//返回 long参数的底模数。  
static int getExponent(double d) ;//返回a的表示中使用的无偏指数 double 。  
static int getExponent(float f) ;//返回a的表示中使用的无偏指数 float 。  
static double hypot(double x, double y) ;//返回sqrt（ x 2 + y 2 ），没有中间溢出或下溢。  
static double IEEEremainder(double f1, double f2) ;//根据IEEE 754标准计算两个参数的余数运算。  
static int incrementExact(int a) ;//返回自变量1，如果结果溢出int，则 int 。  
static long incrementExact(long a) ;//返回一个增加1的参数，如果结果溢出long，则 long 。  
static double log(double a) ;//返回的自然对数（以 e为底） double值。  
static double log10(double a) ;//返回一个 double的基数10对数值。  
static double log1p(double x) ;//返回参数和1的和的自然对数。  
static double max(double a, double b) ;//返回两个 double值中的较大值。  
static float max(float a, float b) ;//返回两个 float的较大值。  
static int max(int a, int b) ;//返回两个 int值中的较大值。  
static long max(long a, long b) ;//返回两个 long的较大值。  
static double min(double a, double b) ;//返回两个 double的较小值。  
static float min(float a, float b) ;//返回两个 float的较小值。  
static int min(int a, int b) ;//返回两个 int的较小值。  
static long min(long a, long b) ;//返回两个 long的较小值。  
static int multiplyExact(int x, int y) ;//返回参数的乘积，如果结果溢出int，则抛出 int 。  
static long multiplyExact(long x, long y) ;//返回参数的乘积，如果结果溢出long，则抛出 long 。  
static int negateExact(int a) ;//返回参数的否定，如果结果溢出int，则 int 。  
static long negateExact(long a) ;//返回参数的否定，如果结果溢出long，则 long 。  
static double nextAfter(double start, double direction) ;//返回与第二个参数方向相邻的第一个参数的浮点数。  
static float nextAfter(float start, double direction) ;//返回与第二个参数方向相邻的第一个参数的浮点数。  
static double nextDown(double d) ;//返回与负无穷大方向相邻的 d的浮点值。  
static float nextDown(float f) ;//返回与负无穷大方向相邻的 f的浮点值。  
static double nextUp(double d) ;//返回与正无穷大方向相邻的 d的浮点值。  
static float nextUp(float f) ;//返回与正无穷大方向相邻的 f的浮点值。  
static double pow(double a, double b) ;//将第一个参数的值返回到第二个参数的幂。  
static double random() ;//返回值为 double值为正号，大于等于 0.0 ，小于 1.0 。  
static double rint(double a) ;//返回与参数最接近值的 double值，并且等于数学整数。  
static long round(double a) ;//返回参数中最接近的 long ，其中 long四舍五入为正无穷大。  
static int round(float a) ;//返回参数中最接近的 int ，其中 int四舍五入为正无穷大。  
static double scalb(double d, int scaleFactor) ;//返回 d 2 scaleFactor四舍五入，好像由单个正确四舍五入的浮点乘以双重值集合的成员执行。  
static float scalb(float f, int scaleFactor) ;//返回 f 2 scaleFactor四舍五入，就像一个正确圆形的浮点数乘以浮点值集合的成员一样。  
static double signum(double d) ;//返回参数的signum函数; 如果参数为零，则为零，如果参数大于零则为1.0，如果参数小于零，则为-1.0。  
static float signum(float f) ;//返回参数的signum函数; 如果参数为零，则为零，如果参数大于零则为1.0f，如果参数小于零，则为-1.0f。  
static double sin(double a) ;//返回角度的三角正弦。  
static double sinh(double x) ;//返回的双曲正弦 double值。  
static double sqrt(double a) ;//返回的正确舍入正平方根 double值。  
static int subtractExact(int x, int y) ;//返回参数的差异，如果结果溢出int，则抛出 int 。  
static long subtractExact(long x, long y) ;//返回参数的差异，如果结果溢出long，则抛出 long 。  
static double tan(double a) ;//返回角度的三角正切。  
static double tanh(double x) ;//返回的双曲正切 double值。  
static double toDegrees(double angrad) ;//将以弧度测量的角度转换为以度为单位的近似等效角度。  
static int toIntExact(long value) ;//返回long参数的值; 如果值溢出int，则int 。  
static double toRadians(double angdeg) ;//将以度为单位的角度转换为以弧度测量的大致相等的角度。  
static double ulp(double d) ;//返回参数的ulp的大小。  
static float ulp(float f) ;//返回参数的ulp的大小。  

```
System类
```java
static void arraycopy(Object src, int srcPos, Object dest, int destPos, int length) ;//将指定源数组中的数组从指定位置复制到目标数组的指定位置。  
static String clearProperty(String key) ;//删除指定键指定的系统属性。  
static Console console() ;//返回与当前Java虚拟机关联的唯一的Console对象（如果有）。  
static long currentTimeMillis() ;//返回当前时间（以毫秒为单位）。  
static void exit(int status) ;//终止当前运行的Java虚拟机。  
static void gc() ;//运行垃圾回收器。  
static Map<String,String> getenv() ;//返回当前系统环境的不可修改的字符串映射视图。  
static String getenv(String name) ;//获取指定环境变量的值。  
static Properties getProperties() ;//确定当前的系统属性。  
static String getProperty(String key) ;//获取指定键指示的系统属性。  
static String getProperty(String key, String def) ;//获取指定键指示的系统属性。  
static SecurityManager getSecurityManager() ;//获取系统安全界面。  
static int identityHashCode(Object x) ;//返回与默认方法hashCode（）返回的给定对象相同的哈希码，无论给定对象的类是否覆盖了hashCode（）。  
static Channel inheritedChannel() ;//返回从创建此Java虚拟机的实体继承的通道。  
static String lineSeparator() ;//返回与系统相关的行分隔符字符串。  
static void load(String filename) ;//加载由filename参数指定的本机库。  
static void loadLibrary(String libname) ;//加载 libname参数指定的本机库。  
static String mapLibraryName(String libname) ;//将库名称映射到表示本地库的平台特定字符串。  
static long nanoTime() ;//以纳秒为单位返回正在运行的Java虚拟机的高分辨率时间源的当前值。  
static void runFinalization() ;//运行任何对象等待定稿的最终化方法。  
static void runFinalizersOnExit(boolean value) ;//已弃用 
//这种方法本质上是不安全的。 它可能导致在活动对象上调用finalizer，而其他线程同时操作这些对象，导致不稳定的行为或死锁。  
static void setErr(PrintStream err) ;//重新分配“标准”错误输出流。  
static void setIn(InputStream in) ;//重新分配“标准”输入流。  
static void setOut(PrintStream out) ;//重新分配“标准”输出流。  
static void setProperties(Properties props) ;//将系统属性设置为 Properties参数。  
static String setProperty(String key, String value) ;//设置由指定键指示的系统属性。  
static void setSecurityManager(SecurityManager s) ;//设置系统安全性。  

```
Obejct类
类层次结构的根，所有类的父类
选中方法按下`Ctrl+V`看源码
重写toString方法
