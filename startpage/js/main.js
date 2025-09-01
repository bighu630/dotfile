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

function initTheme() {
  // 从 localStorage 获取保存的主题，如果没有则使用系统偏好
  const savedTheme = localStorage.getItem("theme");
  const systemPrefersDark = window.matchMedia(
    "(prefers-color-scheme: dark)",
  ).matches;

  if (savedTheme) {
    document.documentElement.setAttribute("data-theme", savedTheme);
  } else if (systemPrefersDark) {
    document.documentElement.setAttribute("data-theme", "dark");
  } else {
    document.documentElement.setAttribute("data-theme", "light");
  }

  updateThemeIcon();
}

function updateThemeIcon() {
  const currentTheme = document.documentElement.getAttribute("data-theme");
  const themeIcon = document.getElementById("theme-icon");

  if (!themeIcon) {
    return;
  }

  if (currentTheme === "dark") {
    // 月亮图标 (暗色模式)
    themeIcon.innerHTML = `
      <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
    `;
  } else {
    // 太阳图标 (亮色模式)
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
}

function toggleTheme() {
  const currentTheme = document.documentElement.getAttribute("data-theme");
  const newTheme = currentTheme === "dark" ? "light" : "dark";

  document.documentElement.setAttribute("data-theme", newTheme);
  localStorage.setItem("theme", newTheme);
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
  window
    .matchMedia("(prefers-color-scheme: dark)")
    .addEventListener("change", (e) => {
      // 只有在用户没有手动设置主题时才跟随系统变化
      if (!localStorage.getItem("theme")) {
        const newTheme = e.matches ? "dark" : "light";
        document.documentElement.setAttribute("data-theme", newTheme);
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
