abstract class Constants {
  static const PAY_CASH = 1;
  static const PAY_ONLINE = 2;
  static const PAY_QR_DRIVER = 3;
  static const PAYMENT_QR_ANTICIPATED = 4;
}

String paymentNameById(int id) {
  if (id == Constants.PAY_CASH) {
    return "CASH";
  } else if (id == Constants.PAY_ONLINE) {
    return "ONLINE";
  } else if (id == Constants.PAY_QR_DRIVER) {
    return "QR AL REPARTIDOR";
  } else if (id == Constants.PAYMENT_QR_ANTICIPATED) {
    return "QR ANTICIPADO";
  }

  return id.toString();
}
