{ lib
, bleak
, bleak-retry-connector
, bluetooth-data-tools
, bluetooth-sensor-state-data
, buildPythonPackage
, cryptography
, fetchFromGitHub
, home-assistant-bluetooth
, poetry-core
, pycryptodomex
, pytestCheckHook
, pythonOlder
, pythonRelaxDepsHook
, sensor-state-data
}:

buildPythonPackage rec {
  pname = "xiaomi-ble";
  version = "0.24.1";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Bluetooth-Devices";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-hKrvV/OzWq07Rb6pU5otNg/A86WnxMKFfs8oA04VvqI=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=xiaomi_ble --cov-report=term-missing:skip-covered" ""
  '';

  nativeBuildInputs = [
    poetry-core
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "pycryptodomex"
  ];

  propagatedBuildInputs = [
    bleak
    bleak-retry-connector
    bluetooth-data-tools
    bluetooth-sensor-state-data
    cryptography
    home-assistant-bluetooth
    pycryptodomex
    sensor-state-data
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "xiaomi_ble"
  ];

  meta = with lib; {
    description = "Library for Xiaomi BLE devices";
    homepage = "https://github.com/Bluetooth-Devices/xiaomi-ble";
    changelog = "https://github.com/Bluetooth-Devices/xiaomi-ble/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
