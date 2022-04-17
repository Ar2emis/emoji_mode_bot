# frozen_string_literal: true

class AirAlert < ApplicationRecord
  PLACES = %w[Луганська Житомирська Черкаська Кіровоградська Київська Львівська Івано-Франківська Хмельницька
              Тернопільська Волинська Рівненська Закарпатська Чернівецька Дніпропетровська Вінницька Запорізька
              Чернігівська Харківська Полтавська Миколаївська Сумська Донецька Херсонська Одеська].freeze
  ALERT_URL = 'https://api.alerts.in.ua/v2/alerts/active.json'
  ALERT_CHECK_PERIOD = 2.minutes
end
