
---------------------------------
--ÖDEV 1
--------------------------------

--Telefon Numarasýnýn Formatlanmasý
--insert into Shippers values('þirket adý', dbo.FormatPhone('2132313213'))

Alter FUNCTION FormatPhone
(
		@Phone NVARCHAR(24)
)
RETURNS NVARCHAR(24)
	Begin
		DECLARE		@Result Nvarchar(24)
		Set			@Phone	= (SELECT RTRIM(LTRIM(@Phone)))
		SET			@Phone  = (SELECT RIGHT(@Phone, 10))			
		SET			@result = (SELECT '+90 ('+(SELECT LEFT(@Phone,3))) + ' ) ' +
		(SELECT SUBSTRING(@Phone,4,3)) + ' ' +
		(SELECT SUBSTRING(@Phone,7,2)) + ' ' + (SELECT SUBSTRING(@Phone,9,2))
		Return @Result;
	End;

--Fonksiyona deger aþagýdaki gibi veriliyor.
Insert Into Shippers Values('AbdulRezzak',dbo.FormatPhone('009634566537'))

	Select * From Shippers
	Order By 1 Desc

---------------------------------
--ÖDEV 2
--------------------------------

-- Tüm açýklamalar mevcut

-- Tablo Adý = " Country ", Parametreler = Id, CountryName,Code
-- Tablo Adý = " City",     Parametreler = Id, CityName, CountryId,Code
-- Tablo Adý = " District", Parametreler = Id, DistrictName, CountryId, CityId,Code
-- Tablo Adý = " Town",     Parametreler = Id, TownName, CountryId, CityId, DistrictId,code


Create Database EartyByCountry;
go
Use EartyByCountry;
Go
Create Table	Countries (
				CountryId		Int Primary Key Identity(1,1) Not Null,
				CountryName		Nvarchar(50) Null,
				Code			Nvarchar(50) Null,
)
Go

Create Table	Cities (
				CityId			Int Primary Key Identity(1,1) Not Null,
				CityName		Nvarchar(50) Null,
				CountryId		Int Foreign Key References Countries,
				Code			Nvarchar(50) Null,
)
Go

Create Table	Districts (
				DistrictId		Int Primary Key Identity(1,1) Not Null,
				DistrictName	Nvarchar(50) Null,
				CountryId		Int Not Null,
				CityId			Int Foreign Key References Cities,
				Code			Nvarchar(50) Null,
)
Go
Create Table	Towns (
				TownId			Int Primary Key Identity(1,1) Not Null,
				TownName		Nvarchar(50) Null, 
				CountryID		Int Not Null, 
				CityId			Int Not Null, 
				DistrictId		Int Foreign Key References Districts,
				Code			Nvarchar(50) Null,
)
---------------------------------------------------------------------------------------

---------------------------------
--ÖDEV 3
--------------------------------

/*
  NOT : Yeni bir veri tabaný kod ile oluþturulacak :)
  1) Yukarýdaki tablolar Code ile oluþturulacak ve kod ile ýliþkilendirilecektir.
  2) Bir adet StoreProcedure yazýlacak ve bu procedure içerisine parametre olarak
  , Ülke Adý, þehir Adý, ýlçe Adý ve Mahalle Adý alacak.
  3) Ülkeler tablosunda parametrede gönderilen ülke var mý yok mu kontrol edilecek. 
    3.1) Eðer Ülke Yok ise Eklenecek. Var ise kullanýcýya mesaj ile bildirilecek
  4) þehirler tablosunda parametrede gönderilen Ülke Kontol edilecek ve 
  Bu ülkeye ait Bölyle bir þejir olup olmadýðý kontrol edilecek. 
    4.1) Eðer þehir yok ise eklenecek. Var ise O ülkenin Id paramtresi yakalanacak ve 
	o Id paramteresine göre þehirler tablosuna kayýt eklenecek.
  5) ýlçeler tablosunda parametrede gönderilen Ülke o ülkeye baðlý þehir ve o þehire baðlý ýlçe varmý yok mu kontrol edilecek.
    5.1) Eðer Ülke Yok ise, Ülke eklenecek. Sonra eklenen ülkenin Id parametresine göre ýl eklenecek. Sonrasýnda ise, ülke Id ve ýl Id parametreleri yakalanýp ilçe eklenecek.
    5.2) Eðer Ülke var þehir yok ise, parametrede gönderilen ülke Id yakalanýp þehir eklenecek ve Ulke Id ile þehir Id parametrelerini kullanarak ýlçeyi Eklenecek.
  6) Mahalle tablosunda parametrede gönderilen Ülke, o ülkeye baðlý þehir, o þehire baðlý ilçe varmý yok mu kontrol edilecek.
    6.1) Eðer Ülke yok ise; Önce Ülke eklenecek ve o ülkenin Id parametresine göre ýl, Ülke ve ýl Id parametrelerine göre ilçe, Ulke ýl ve ýlçe Id parametrelerine göre de Mahalle eklenecek.
    6.2) Eðer ülke var ise ve þehir yok  ise O ülke Id parametresine göre þehir,, Ülke ve þehir Id parametresine göre ýlçe, Ülke  þehir ilçe Id parametrelerine göre Mahalle eklenecek.
    6.3) Eðer ülke ýl var ama ilçe yok ise, Ülke þehir Id parametreleri yakalanacak ve ýlçe eklenecek. Sonrasýnda Ülke þehir ve ýlçe Id parametreleri yakalnarak Mahalle Eklenecek
    6.4) Eðer ülke il ilçe var ama mahalle yok ise, Ülke ýl ýlçe Id parametreleri kullanýlarak Mahalle eklenecektir.
	NOT : ýl ve þehir Ayný Anlama Gelir :) artý (+) her blok içerisinde mesaj verilecek
*/

Create Proc sp_AddCountriesToDatabase
			@AddCountries	Nvarchar(50),
			@AddCities		Nvarchar(50),
			@AddDistricts	Nvarchar(50),
			@AddTowns		Nvarchar(50)
As

Declare		@CountryName		Nvarchar(50), 
			@CityName			Nvarchar(50), 
			@DistrictName		Nvarchar(50),
			@TownName			Nvarchar(50),
			@GetTownName		Nvarchar(50),
			@GetCountryName		Nvarchar(50),
			@GetCityName		Nvarchar(50),
			@GetDistrictName	Nvarchar(50),
			@CountryId			Int,
			@CityId				Int,
			@DistrictId			Int

		SET @GetCountryName  = @AddCountries
		Set @GetCityName	 = @AddCities
		Set @GetDistrictName = @AddDistricts
		Set @GetTownName	 = @AddTowns

Set		@CountryName = '-'
Select  @CountryName = CountryName
From	Countries
Where	CountryName = @GetCountryName 

If (@CountryName = @GetCountryName)
					Begin								
							Print @GetCountryName +' '+'Ülkesi Mevcuttur.'
					End
If(@CountryName != @GetCountryName)
					Begin
								Insert Into Countries Values(@GetCountryName, GetDate())

							Print @GetCountryName +' '+'Ülkesi Eklendi...'
					End
---------------------------------------------------------------------------------------
Set		@CityName = '-'
Select  @CityName = CityName 
From	Cities
Where	CityName = @GetCityName

If(@CityName = @GetCityName)
					Begin 			
							Print @GetCityName +' '+'Þehri Mevcuttur.'
					End
if(@GetCityName != @CityName)
					Begin				
							Select @CountryId =  CountryId
							From Countries			
							Where CountryName = @GetCountryName
							
								Insert Into Cities Values(@GetCityName,@CountryId,getdate())			
							
							Print @GetCityName +' '+'Þehri Eklendi...'
					End
-------------------------------------------------------------			
Set		@DistrictName = '-'
Select  @DistrictName = DistrictName
From	Districts 
Where   DistrictName = @GetDistrictName

If (@DistrictName = @GetDistrictName)
					Begin
							Print @GetDistrictName +' '+'Ýlçesi Mevcuttur.'
					End
If (@DistrictName != @GetDistrictName)
					Begin
							Select  @CityId = CityId, 
									@CountryId = CountryId
							From Cities 
							Where CityName = @GetCityName
						
								Insert Into Districts Values(@GetDistrictName,@CountryId,@CityId, Getdate())

							Print @GetDistrictName +' '+'Ýlçesi Eklendi...'
					End
-----------------------------------------------------------
Set		@TownName = '-'
Select	@TownName = TownName 
From	Towns
Where	@TownName = @GetTownName

if(@GetTownName = @TownName)
					Begin
							Print @GetTownName +' '+'Mahallesi Mevcuttur.'
					End
if(@GetTownName != @TownName)
					Begin
							Select  @CountryId = CountryId,
									@CityId = CityId,
									@DistrictId = DistrictId
							From Districts 							
							Where DistrictName = @GetDistrictName
							
								Insert Into Towns Values(@GetTownName, @CountryId, @CityId, @DistrictId, GETDATE())

							Print @GetTownName +' '+'Mahallesi Eklendi...'
					End

		

--Execute Stored procedure 

					EXEC sp_AddCountriesToDatabase 'Almanya','Berlin','Tempelhof','Schöneberg'

-----------------------------------------------------------------------------------------------------

---------------------------------
--ÖDEV 4
--------------------------------
-- Function ödev 

-- Parametre olarak verilen doðum tarihi ve yaþ deðerlerini alarak kiþi belirtilen yaþý Yýl - Ay veya Gün olarak doldurup doldurmadýðýný geri dönen Function

Alter Function AgeCalculate
			(	
				@GetBirthdate	datetime,
				@GetAge			Int
			)
Returns Nvarchar(50)
	Begin
		Declare	@YearHoursDived	Nvarchar(50),		
				@Result			Nvarchar(50)
		Set		@YearHoursDived = DATEDIFF(HOUR , @GetBirthdate , GETDATE())/8766
	
				if(@YearHoursDived = @GetAge)
						Begin
								Set	@Result = 'Dogum Tarihi Ýçin Yaþ Doðru Girilmiþdir.'
						End

				if(@YearHoursDived != @GetAge)
						Begin
								Set	@Result = 'Dogum Tarihi veya Yaþ Yanlýþtýr..'
						End
		Return @Result
	End
--Select dbo.AgeCalculate('2000-12-05' , 20) Yanlýþdýr çunku 20 yas için 12 aralýk ayý girmemiþtir.
Select dbo.AgeCalculate('2000-12-05' , 19)