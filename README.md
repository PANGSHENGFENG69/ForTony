### 第一項

已經把需要知道的東西 都寫在專案裡面了，有空在深入 了解 這樣寫的目的 是什麼

### 第二項

基本上就直接這樣沿用下去，UI的部分建議可以從 Flutter官網學習 , URL : https://docs.flutter.dev/ui/widgets

### 第三項

基本上 Flutter 不是像 Vue 這種寫法，比較偏向 React 的寫法

Vue的話 是自動雙向綁定UI
React的話 ，看是要用 原生的 Function (useMemo/useEffect/useState/setState) 來更新UI 或 使用套件 Redux

### 第四項 - State管理 (Provider/Riverpod/Bloc/GetX) ，個人覺得：不建議 GetX ，個人推薦：Provider/Riverpod (幾乎一樣 依賴 read/watch)

這專案 是用 Provider 來控制值來改變 UI 類似 Redux的做法
Provider 的好處是 1.自動 DI + state 分享
2.Flutter團隊發明的
