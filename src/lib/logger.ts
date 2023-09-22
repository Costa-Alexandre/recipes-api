import expressWinston from 'express-winston';
import winston, { transports, format } from 'winston'

const level = () => {
  const env = process.env.NODE_ENV || 'development'
  const isDevelopment = env === 'development'
  return isDevelopment ? 'debug' : 'warn'
}

const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4,
}

const logFormat = format.combine(
  format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
  format.errors({ stack: true }),
  format.json(),
  format.prettyPrint(),
  format.printf(({ level, message, timestamp }) => {
    return `${timestamp} ${level.toUpperCase()}: ${message}`;
  })
)

const errorFormat = format.combine(
  format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
  format.errors({ stack: true }),
  format.json(),
  format.prettyPrint(),
  format.printf(({ level, meta, timestamp }) => {
    return `${timestamp} ${level.toUpperCase()}: ${meta.error}`;
  })
)

const loggerTransports: (transports.ConsoleTransportInstance | transports.FileTransportInstance)[] = [
  new transports.File({
    level: 'warn',
    filename: 'logs/warn.log',
  }),
]

if (process.env.NODE_ENV !== 'production') {
  loggerTransports.push(
    new transports.Console()
  )
}

export const reqLogger = expressWinston.logger({
  transports: loggerTransports,
  format: logFormat,
  level: level(),
  statusLevels: true,
  expressFormat: true,
  meta: true,
})

export const errorLogger = expressWinston.errorLogger({
  transports: [
    new transports.Console(),
    new transports.File({
      filename: 'logs/internalError.log',
      level: 'error'
    })
  ],
  format: errorFormat
})

export const logger = winston.createLogger({
  level: level(),
  levels,
  format: logFormat,
  transports: loggerTransports,
})