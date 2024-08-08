import { InferInsertModel, InferSelectModel } from 'drizzle-orm'
import { integer, real, sqliteTable, text } from 'drizzle-orm/sqlite-core'
import { createInsertSchema, createSelectSchema } from 'drizzle-valibot'

// User
export const UserTable = sqliteTable('User', {
  id: text('id').primaryKey(),
  email: text('email').notNull().unique(),
  name: text('name'),
  createdAt: integer('created_at', { mode: 'timestamp' }).notNull().defaultNow(),
})

export type User = InferSelectModel<typeof UserTable>
export type InsertUser = InferInsertModel<typeof UserTable>
export const insertUserSchema = createInsertSchema(UserTable)
export const selectUserSchema = createSelectSchema(UserTable)

// Trip
export const TripTable = sqliteTable('Trip', {
  id: text('id').primaryKey(),
  userId: text('user_id')
    .notNull()
    .references(() => UserTable.id),
  name: text('name').notNull(),
  purpose: text('purpose'),
  startDate: integer('start_date', { mode: 'timestamp' }).notNull(),
  endDate: integer('end_date', { mode: 'timestamp' }),
  startOdometer: real('start_odometer'),
  endOdometer: real('end_odometer'),
})

export type Trip = InferSelectModel<typeof TripTable>
export type InsertTrip = InferInsertModel<typeof TripTable>
export const insertTripSchema = createInsertSchema(TripTable)
export const selectTripSchema = createSelectSchema(TripTable)

// Event
export const EventTable = sqliteTable('Event', {
  id: text('id').primaryKey(),
  tripId: text('trip_id').references(() => TripTable.id),
  userId: text('user_id')
    .notNull()
    .references(() => UserTable.id),
  title: text('title').notNull(),
  description: text('description'),
  startDate: integer('start_date', { mode: 'timestamp' }).notNull(),
  endDate: integer('end_date', { mode: 'timestamp' }),
  latitude: real('latitude'),
  longitude: real('longitude'),
  category: text('category'),
})

export type Event = InferSelectModel<typeof EventTable>
export type InsertEvent = InferInsertModel<typeof EventTable>
export const insertEventSchema = createInsertSchema(EventTable)
export const selectEventSchema = createSelectSchema(EventTable)

// Expense
export const ExpenseTable = sqliteTable('Expense', {
  id: text('id').primaryKey(),
  tripId: text('trip_id').references(() => TripTable.id),
  userId: text('user_id')
    .notNull()
    .references(() => UserTable.id),
  amount: real('amount').notNull(),
  currency: text('currency').notNull(),
  date: integer('date', { mode: 'timestamp' }).notNull(),
  category: text('category'),
  description: text('description'),
})

export type Expense = InferSelectModel<typeof ExpenseTable>
export type InsertExpense = InferInsertModel<typeof ExpenseTable>
export const insertExpenseSchema = createInsertSchema(ExpenseTable)
export const selectExpenseSchema = createSelectSchema(ExpenseTable)

// Attachment
export const AttachmentTable = sqliteTable('Attachment', {
  id: text('id').primaryKey(),
  eventId: text('event_id').references(() => EventTable.id),
  expenseId: text('expense_id').references(() => ExpenseTable.id),
  userId: text('user_id')
    .notNull()
    .references(() => UserTable.id),
  type: text('type').notNull(), // e.g., 'receipt', 'photo', 'voice_recording'
  url: text('url').notNull(),
  createdAt: integer('created_at', { mode: 'timestamp' }).notNull().defaultNow(),
})

export type Attachment = InferSelectModel<typeof AttachmentTable>
export type InsertAttachment = InferInsertModel<typeof AttachmentTable>
export const insertAttachmentSchema = createInsertSchema(AttachmentTable)
export const selectAttachmentSchema = createSelectSchema(AttachmentTable)

// CalendarIntegration
export const CalendarIntegrationTable = sqliteTable('CalendarIntegration', {
  id: text('id').primaryKey(),
  userId: text('user_id')
    .notNull()
    .references(() => UserTable.id),
  provider: text('provider').notNull(), // e.g., 'google', 'apple', 'microsoft'
  accessToken: text('access_token'),
  refreshToken: text('refresh_token'),
  expiresAt: integer('expires_at', { mode: 'timestamp' }),
})

export type CalendarIntegration = InferSelectModel<typeof CalendarIntegrationTable>
export type InsertCalendarIntegration = InferInsertModel<typeof CalendarIntegrationTable>
export const insertCalendarIntegrationSchema = createInsertSchema(CalendarIntegrationTable)
export const selectCalendarIntegrationSchema = createSelectSchema(CalendarIntegrationTable)

// Vehicle (replacing Car for our use case)
export const VehicleTable = sqliteTable('Vehicle', {
  id: text('id').primaryKey(),
  userId: text('user_id')
    .notNull()
    .references(() => UserTable.id),
  make: text('make').notNull(),
  model: text('model').notNull(),
  year: integer('year').notNull(),
  licensePlate: text('license_plate'),
  fuelType: text('fuel_type'),
})

export type Vehicle = InferSelectModel<typeof VehicleTable>
export type InsertVehicle = InferInsertModel<typeof VehicleTable>
export const insertVehicleSchema = createInsertSchema(VehicleTable)
export const selectVehicleSchema = createSelectSchema(VehicleTable)
