
-- 1. Ödev  bir mail adresinden istenilen datalar
-- murat.vuranok@bilgeadam.com
-- 1) isim
-- 2) soyisim
-- 3) domain
-- 4) mail

DECLARE @NameSurname NVARCHAR(20), @FirstName NVARCHAR(20), @LastName NVARCHAR(20), @Mail  NVARCHAR(40), @Domain NVARCHAR(25), @Extension NVARCHAR(25), @Com NVARCHAR(20)
SET @Mail = 'murat.vuranok@bilgeadam.com'

SELECT @NameSurname = lEFT(@Mail, (SELECT CHARINDEX('@', @Mail)) - 1)
SELECT @FirstName = LEFT(@NameSurname, (SELECT CHARINDEX('.', @NameSurname)) - 1)
SELECT @LastName = RIGHT( @NameSurname, ((SELECT LEN(@NameSurname))-(SELECT CHARINDEX('.', @NameSurname))))
SELECT @Extension = RIGHT( @Mail, ((SELECT LEN(@Mail))-(SELECT CHARINDEX('@', @Mail))))
SELECT @Domain = LEFT( @Extension, (SELECT CHARINDEX('.', @Extension)) - 1)
SELECT @Com = RIGHT( @Extension, 3)

PRINT 'Adý    : ' + @FirstName
PRINT 'Soyadý : ' + @LastName
PRINT 'Mail   : ' + @Mail
PRINT 'Domain : ' + @Domain
PRINT 'Uzantý : ' + @Com


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

-- 2. Ödev bir telefon numarasýný formatlayýnýz.
-- 5324567890    => +90 (532) 123 45 67
-- 05324567890   => +90 (532) 123 45 67

DECLARE @Phone NVARCHAR(20), @PhoneFirstSix NVARCHAR(20), @PhoneLastFour NVARCHAR(20)
SET @Phone = '09871234567';
SET @Phone = (SELECT RIGHT('9871234567', 10))
SET @PhoneFirstSix = (SELECT RIGHT('9871234567', 6))
SET @PhoneLastFour = (SELECT RIGHT('9871234567', 4))

SELECT '+90 ('+(SELECT LEFT(@PhoneFirstSix,3))+') '+(SELECT RIGHT(@PhoneFirstSix,3))+' '+(SELECT LEFT(@PhoneLastFour,2))+' '+(SELECT RIGHT(@PhoneLastFour,2))


