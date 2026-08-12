function dateTime() {
  const date = new Date();
  let today = date.toDateString();
  let time = date.toLocaleTimeString();
  document.getElementById("date-time").innerHTML =
    '<p id="date">' + today + '</p><p id="time">' + time + "</p>";
  setTimeout(dateTime, 1000);
}

function weatherBalloon(cityID) {
  var apiKey = ""; //OpenWeather API key
  fetch(
    "https://api.openweathermap.org/data/2.5/weather?id=" +
      cityID +
      "&appid=" +
      apiKey,
  )
    .then(function (resp) {
      return resp.json();
    })
    .then(function (data) {
      let weatherIcon = data.weather[0].icon;
      let tempK = parseFloat(data.main.temp);
      let tempC = Math.round(tempK - 273.15);
      let tempF = Math.round((tempK - 273.15) * 1.8) + 32;
      document.getElementById("weather").innerHTML =
        '<p id="location">' +
        data.name +
        '</p><p id="details" ' +
        'title="' +
        tempF +
        '&deg;F">' +
        '<img src="https://openweathermap.org/img/wn/' +
        weatherIcon +
        '.png">' +
        data.weather[0].description +
        '<span class="separator">|</span>' +
        tempC +
        "&deg;C</p>";
    });
}

function getSystemTheme() {
  return window.matchMedia("(prefers-color-scheme: dark)").matches
    ? "dark"
    : "light";
}

// 当前模式: "auto"(跟随系统) / "dark" / "light"(手动)
function getThemeMode() {
  const saved = localStorage.getItem("theme");
  return saved === "dark" || saved === "light" ? saved : "auto";
}

// 实际生效的主题:手动设置优先，否则取系统偏好
function getEffectiveTheme() {
  const mode = getThemeMode();
  return mode === "auto" ? getSystemTheme() : mode;
}

function initTheme() {
  const mode = getThemeMode();

  if (mode === "auto") {
    // 自动模式:不设置 data-theme，由 CSS media query 自动跟随系统
    document.documentElement.removeAttribute("data-theme");
  } else {
    // 手动模式:应用用户选择的主题
    document.documentElement.setAttribute("data-theme", mode);
  }

  updateThemeIcon();
}

function updateThemeIcon() {
  const mode = getThemeMode();
  const themeIcon = document.getElementById("theme-icon");

  if (!themeIcon) {
    return;
  }

  if (mode === "auto") {
    // 半太阳 + 月牙:自动跟随系统
    themeIcon.innerHTML = `
      <path d="M12 2a10 10 0 0 0 0 20"></path>
      <path d="M18 7a7 7 0 0 1 0 10a5 5 0 0 0 0-10z"></path>
    `;
  } else if (mode === "dark") {
    // 月亮图标 (手动深色)
    themeIcon.innerHTML = `
      <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
    `;
  } else {
    // 太阳图标 (手动浅色)
    themeIcon.innerHTML = `
      <circle cx="12" cy="12" r="5"></circle>
      <line x1="12" y1="1" x2="12" y2="3"></line>
      <line x1="12" y1="21" x2="12" y2="23"></line>
      <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
      <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
      <line x1="1" y1="12" x2="3" y2="12"></line>
      <line x1="21" y1="12" x2="23" y2="12"></line>
      <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
      <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
    `;
  }

  // 更新按钮提示与模式标记
  const themeToggleBtn = document.getElementById("theme-toggle-btn");
  if (themeToggleBtn) {
    themeToggleBtn.setAttribute("data-mode", mode);
    const titles = {
      auto:
        "自动跟随系统 (当前: " +
        (getSystemTheme() === "dark" ? "深色" : "浅色") +
        ") · 点击切换",
      dark: "手动深色模式 · 点击切换",
      light: "手动浅色模式 · 点击切换",
    };
    themeToggleBtn.title = titles[mode];
  }
}

function toggleTheme() {
  const mode = getThemeMode();
  // 三态循环: auto → dark → light → auto
  let newMode;
  if (mode === "auto") {
    newMode = "dark";
  } else if (mode === "dark") {
    newMode = "light";
  } else {
    newMode = "auto";
  }

  if (newMode === "auto") {
    document.documentElement.removeAttribute("data-theme");
  } else {
    document.documentElement.setAttribute("data-theme", newMode);
  }
  localStorage.setItem("theme", newMode);
  updateThemeIcon();
}

function initThemeToggle() {
  const themeToggleBtn = document.getElementById("theme-toggle-btn");

  if (themeToggleBtn) {
    themeToggleBtn.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();
      toggleTheme();
    });
  }

  // 监听系统主题变化
  // 自动模式下，颜色由 CSS media query 自动跟随系统，这里只需更新图标和提示
  window
    .matchMedia("(prefers-color-scheme: dark)")
    .addEventListener("change", () => {
      if (getThemeMode() === "auto") {
        updateThemeIcon();
      }
    });
}

function traichu() {
  dateTime();
  weatherBalloon(1850147); //OpenWeather city ID
  initTheme();
  initThemeToggle();
}
